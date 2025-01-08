import 'package:flutter/material.dart';
import '../components/grid.dart';
import '../components/keyboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle - IT Edition'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(color: Colors.yellow[700],
            child: const Grid(),
            )),
          Expanded(
            flex: 3,
            child: Container(color: Colors.cyan[400],
            child: Column(
              children: const [
                KeyboardRow(min: 1, max: 10,),
                KeyboardRow(min: 11, max: 20,),
                KeyboardRow(min: 21, max: 28,)
              ],
            ),
            )),
        ],
      ),
    );
  }
}
