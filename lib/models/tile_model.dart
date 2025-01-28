import 'package:wordle_it_edition/constants/answers.dart';

class TileModel {
  final String letter;
  AnswerStage answerStage;

  TileModel({required this.letter, required this.answerStage});
}