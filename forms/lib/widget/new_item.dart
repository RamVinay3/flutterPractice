import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms/data/categories.dart';
import 'package:forms/models/category.dart';
import 'package:forms/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  var name = '';
  var quantity = 1;
  var cat = categories[Categories.fruit];
  void _saveItem() async {
    setState(() {
      _isSending = true;
    });
    if (_formKey.currentState!
            .validate() // will return true if every validator is true

        ) {
      _formKey.currentState!
          .save(); //it performs onsaved operation on every input field.
      final url = Uri.https(
          'forms-eb9f4-default-rtdb.firebaseio.com', 'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Conent-Type':
              'application/json' //it tell us to server to which format it has to be connected
        },
        body: json.encode(
          {
            'name': name,
            'quantity': quantity,
            'category': cat?.type,
          },
        ),
      );
      print(response.body);
      if (!context.mounted) {
        return;
      }
      setState(() {
        _isSending = false;
      });
      // Navigator.of(context).pop();
      final Map<String, dynamic> resdata = json.decode(response.body);

      Navigator.of(context).pop(
        GroceryItem(
            id: resdata["name"], name: name, quantity: quantity, category: cat),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Name')),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1) {
                  return "Must be between 1 and 50 charachters";
                }
                return null;
                //this is error message and value is default
              },
              onSaved: (value) {
                name = value!;
                //you can do whatever you want here.
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: '1',
                    decoration: const InputDecoration(
                      label: Text('quantity'),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          int.tryParse(value)! <= 0) {
                        return "Must be a valid,Positive number";
                      }
                      return null;
                      //this is error message and value is default
                    },
                    onSaved: (value) {
                      quantity = int.parse(value!);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField(
                    value: cat,
                    items: [
                      for (final categories in categories.entries)
                        DropdownMenuItem(
                            value: categories.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: categories.value.color,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(categories.value.type)
                              ],
                            ))
                    ],
                    onChanged: (value) {
                      cat = value;
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSending
                      ? null
                      : () {
                          _formKey.currentState!.reset();
                        },
                  child: Text('reset'),
                ),
                ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child:
                        _isSending ? const Text('Saving') : const Text('save'))
              ],
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: content,
    );
  }
}
