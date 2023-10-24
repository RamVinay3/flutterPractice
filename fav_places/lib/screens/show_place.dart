import 'package:flutter/material.dart';
import 'package:fav_places/Models/place.dart';

class ShowPlace extends StatefulWidget {
  const ShowPlace({super.key, required this.place});
  final Place place;

  @override
  State<ShowPlace> createState() => _ShowPlaceState();
}

class _ShowPlaceState extends State<ShowPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            widget.place.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
