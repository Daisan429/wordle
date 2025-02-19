import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_it_edition/anima/bounce.dart';
import 'package:wordle_it_edition/anima/dance.dart';
import 'package:wordle_it_edition/components/tile.dart';
import 'package:wordle_it_edition/controller.dart';

class Grid extends StatefulWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(35, 10, 35, 20),
      itemCount: 25,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Consumer<Controller>(
          builder: (_, notifier, __) {
            bool animate = false;
            bool animateDance = false;
              int danceDelay = 1600;
              if (index == (notifier.currentTile - 1) &&
                  !notifier.backOrEnterTapped) {
                animate = true;
              }
              if (notifier.gameWon) {
                for (int i = notifier.tilesEntered.length - 5;
                    i < notifier.tilesEntered.length;
                    i++) {
                  if (index == i) {
                    animateDance = true;
                    danceDelay += 150 * (i - ((notifier.currentRow - 1) * 5));
                  }
                }
              }
              return Dance(
                delay: danceDelay, animate: animateDance,
                child: Bounce(animate: animate,
                child: Tile(index: index)),
              );
            },
          );
        });
  }
}
