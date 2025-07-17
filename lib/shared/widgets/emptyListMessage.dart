import 'package:flutter/material.dart';

class Emptylistmessage extends StatelessWidget {
  final String message;
  const Emptylistmessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
