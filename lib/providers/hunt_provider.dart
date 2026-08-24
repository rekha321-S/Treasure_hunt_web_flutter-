import 'package:flutter/material.dart';
import '../models/clue.dart';

class HuntProvider extends ChangeNotifier {
  final List<Clue> _clues = [
    Clue(
      id: '1',
      text: "I speak without a mouth and hear without ears. I have no body, but I come alive with wind. What am I?",
      answer: "echo",
    ),
    Clue(
      id: '2',
      text: "You measure my life in hours and I serve you by expiring. I'm quick when I'm thin and slow when I'm fat. The wind is my enemy.",
      answer: "candle",
    ),
    Clue(
      id: '3',
      text: "I have cities, but no houses. I have mountains, but no trees. I have water, but no fish. What am I?",
      answer: "map",
      points: 20,
    ),
  ];

  int _currentClueIndex = 0;
  int _score = 0;
  bool _isHuntFinished = false;

  List<Clue> get clues => _clues;
  int get currentClueIndex => _currentClueIndex;
  Clue get currentClue => _clues[_currentClueIndex];
  int get score => _score;
  bool get isHuntFinished => _isHuntFinished;
  double get progress => _clues.isEmpty ? 0 : _currentClueIndex / _clues.length;

  bool submitAnswer(String answer) {
    if (answer.trim().toLowerCase() == currentClue.answer.toLowerCase()) {
      _score += currentClue.points;
      if (_currentClueIndex < _clues.length - 1) {
        _currentClueIndex++;
      } else {
        _isHuntFinished = true;
      }
      notifyListeners();
      return true;
    }
    return false;
  }
  
  void restartHunt() {
    _currentClueIndex = 0;
    _score = 0;
    _isHuntFinished = false;
    notifyListeners();
  }
}
