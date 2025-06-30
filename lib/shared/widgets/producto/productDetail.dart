import 'package:flutter/material.dart';

class Productdetail extends StatelessWidget {
  final String label;
  final String value;
  final Color? valuerColor;

  const Productdetail({
    super.key,
    required this.label,
    required this.value,
    this.valuerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valuerColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
