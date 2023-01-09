import 'package:flutter/material.dart';

class DettaleScreen extends StatefulWidget {
  const DettaleScreen({Key? key}) : super(key: key);

  @override
  State<DettaleScreen> createState() => _DettaleScreen();
}

class _DettaleScreen extends State<DettaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        elevation: 0,
      ),
      body: const Center(child:Text("Hola mundo")),
    );
  }
}