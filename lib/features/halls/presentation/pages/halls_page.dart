import 'package:flutter/material.dart';
class HallsPage extends StatefulWidget {
  const HallsPage({super.key});
  @override
  State<HallsPage> createState() => _HallsPageState();
}
class _HallsPageState extends State<HallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halls Page'),
      ),
      body: Center(child: Text("Halls Page"),),
    );
  }
}
