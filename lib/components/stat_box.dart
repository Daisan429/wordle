import 'package:flutter/material.dart';
import 'package:wordle_it_edition/components/stat_tile.dart';
import 'package:wordle_it_edition/constants/answers.dart';
import 'package:wordle_it_edition/data/keys_map.dart';
import 'package:wordle_it_edition/main.dart';
import 'package:wordle_it_edition/stats/calcu_stat.dart';


class StatsBox extends StatelessWidget {
  const StatsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.12,
          size.width * 0.08, size.height * 0.12),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear)),
          const Expanded(
              child: Text('STATS', textAlign: TextAlign.center)),
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: getStats(),
              builder: (context, snapshot) {
                List<String> results = ['0', '0', '0', '0', '0'];
                if (snapshot.hasData) {
                  results = snapshot.data as List<String>;
                }
                return Row(
                  children: [
                    StatsTile(heading: 'Played', value: int.parse(results[0])),
                    StatsTile(heading: 'Win %', value: int.parse(results[2])),
                    StatsTile(heading: 'Current\nStreak', value: int.parse(results[3])),
                    StatsTile(heading: 'Max\nStreak', value: int.parse(results[4])),
                  ],
                );
              },
            ),
          ),
          Expanded(
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    keysMap.updateAll(
                        (key, value) => value = AnswerStage.notAnswered);

                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => const MyApp()),
                        (route) => false);
                  },
                  child: const Text('New Game', style: TextStyle(fontSize: 30))))
        ],
      ),
    );
  }
}
