import 'package:fav_places/Models/place.dart';
import 'package:fav_places/main.dart';
import 'package:fav_places/providers/places.dart';
import 'package:fav_places/widgets/image_input.dart';
import 'package:fav_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io';

class AddFavPlace extends ConsumerStatefulWidget {
  const AddFavPlace({super.key});

  @override
  ConsumerState<AddFavPlace> createState() => _AddFavPlaceState();
}

class _AddFavPlaceState extends ConsumerState<AddFavPlace> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  File? _selectedImage;

  void pickedImage(File imageFile) {
    _selectedImage = imageFile;
  }

  @override
  Widget build(BuildContext context) {
    // final places = ref.watch(placeprovider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      label: Text('enter place'), fillColor: Colors.white),
                  validator: (value) {
                    if (value == '' || value == null || value.trim() == '') {
                      return 'must be filled properly';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    print(value);
                    title = value.toString();
                  },
                ),
                ImageInput(
                  onPickImage: pickedImage,
                ),
                // const LocationInput(),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ref
                          .read(placeprovider.notifier)
                          .addPlace(title: title, image: _selectedImage!);
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('add place'),
                ),
              ],
            )),
      ),
    );
  }
}
