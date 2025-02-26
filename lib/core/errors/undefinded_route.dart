import 'package:flutter/material.dart';

class UnDefinedRoute extends StatelessWidget {
  const UnDefinedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DefinedRoute"),
      ),
      backgroundColor: Colors.grey,
    );
  }
}