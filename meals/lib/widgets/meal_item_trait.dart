import 'package:flutter/material.dart';

class Trait extends StatelessWidget {
  const Trait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;
  @override
  Widget build(context) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
