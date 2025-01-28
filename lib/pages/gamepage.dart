import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_it_edition/components/stat_box.dart';
import 'package:wordle_it_edition/constants/words.dart';
import 'package:wordle_it_edition/controller.dart';
import 'package:wordle_it_edition/notice.dart';
import 'package:wordle_it_edition/pages/settings.dart';
import '../components/grid.dart';
import '../components/keyboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late String _word;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    _word = words[r];
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp){
    Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle - IT Edition'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickBox(context: context, message: 'KULANG GAR!!');
              }
              if (notifier.gameCompleted) {
                if (notifier.gameWon) {
                  if (notifier.currentRow == 5) {
                    runQuickBox(context: context, message: 'MUNTIKAN KA NA GAR!!');
                  } else {
                    runQuickBox(context: context, message: 'LAKAS MO GAR!!');
                  }
                } else {
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(
                  const Duration(milliseconds: 4000),(){
                    if (mounted) {
                      showDialog(
                          context: context, builder: (_) => const StatsBox());
                    }
                  },
                );
              }
              return IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context, builder: (_) => const StatsBox());
                  },
                  icon: const Icon(Icons.bar_chart_outlined));
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 3,
          ),
          const Expanded(
            flex: 7,
            child: Grid()),
          Expanded(
            flex: 3,
            child: Column(
              children: const [
                const Divider(
                  height: 1,
                  thickness: 2,
                ),
                KeyboardRow(min: 1, max: 10,),
                KeyboardRow(min: 11, max: 20,),
                KeyboardRow(min: 21, max: 28,)
              ],
            )),
        ],
      ),
    );
  }
}
