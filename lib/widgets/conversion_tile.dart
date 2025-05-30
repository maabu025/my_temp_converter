import 'package:flutter/material.dart';

class ConversionTile extends StatelessWidget {
  final String record;

  ConversionTile(this.record);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(record),
    );
  }
}
