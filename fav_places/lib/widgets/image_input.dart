import 'package:fav_places/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File Image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void takePicture() async {
    final imagePicker = ImagePicker();
    final picture =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (picture == null) return;
    setState(() {
      _selectedImage = File(picture.path);
    });
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: () {
        takePicture();
      },
      icon: const Icon(Icons.camera),
      label: const Text('Take picture'),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () {
          takePicture();
        },
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: colorScheme.outline,
        ),
      ),
      width: double.infinity,
      child: content,
    );
  }
}
