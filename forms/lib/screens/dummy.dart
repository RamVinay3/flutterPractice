import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms/data/categories.dart';
import 'package:forms/models/grocery_item.dart';
import 'package:forms/widget/new_item.dart';
import 'package:http/http.dart' as http;

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String _iserror = '';
  void loadItem() async {
    final url = Uri.https(
        'forms-eb9f4-default-rtdb.firebaseio.com', 'shopping-list.json');
    try {
      final res = await http.get(url);
      print(res.body);
      if (res.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      if (res.statusCode > 400) {
        setState(() {
          _iserror =
              "cannot fetch data at the moment.Please try again after sometime";
        });
      }
      final Map<String, dynamic> datalist = json.decode(res.body);
      final List<GroceryItem> grocery = [];

      for (var item in datalist.entries) {
        final categorylocal = categories.entries.firstWhere(
          (catItem) => catItem.value.type == item.value["category"],
        ); //.value;
        grocery.add(
          GroceryItem(
            id: item.key,
            name: item.value["name"],
            quantity: item.value["quantity"],
            category: categorylocal.value,
          ),
        );
      }
      if (grocery.isEmpty) return;
      setState(() {
        _groceryItems = grocery;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _iserror = 'something went wrong .Please try again...!';
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) {
        return const NewItem();
      }),
    );
    if (newItem == null) return;
    setState(() {
      _groceryItems.add(newItem);
    });
    loadItem();
  }

  @override
  void initState() {
    super.initState();
    loadItem();
  }

  void _removeItem(item) async {
    setState(() {
      _groceryItems.remove(item);
    });
    final index = _groceryItems.indexOf(item);
    final url = Uri.https('forms-eb9f4-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final res = await http.delete(url);
    if (res.statusCode >= 400) {
      //we can put optional message to the user.
      _groceryItems.insert(index, item);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('Add a Grocery Item'),
    );
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_iserror.isNotEmpty) {
      content = Center(
        child: Text(_iserror),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, i) {
            return Dismissible(
              key: ValueKey(_groceryItems[i].id),
              onDismissed: (direction) {
                _removeItem(_groceryItems[i]);
              },
              child: ListTile(
                title: Text(_groceryItems[i].name),
                leading: Container(
                  color: _groceryItems[i].category?.color,
                  height: 20,
                  width: 20,
                ),
                trailing: Text(_groceryItems[i].quantity.toString()),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Groceries'),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: content
        //      ListView(
        //   children: [
        //     for (var i = 0; i < groceryItems.length; i++)
        //       Row(
        //         children: [
        //           Container(
        //             color: groceryItems[i].category?.color,
        //             child: const SizedBox(
        //               height: 20,
        //               width: 20,
        //             ),
        //           ),
        //           const SizedBox(
        //             width: 20,
        //           ),
        //           Text(groceryItems[i].name),
        //           const SizedBox(
        //             width: 90,
        //           ),
        //           Text(
        //             groceryItems[i].quantity.toString(),
        //             textAlign: TextAlign.end,
        //           )
        //         ],
        //       )
        //   ],
        // )
        );
  }
}
