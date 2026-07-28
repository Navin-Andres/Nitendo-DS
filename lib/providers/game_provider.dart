import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  List games = [];

  void setGames(List newGames) {
    games = newGames;
    notifyListeners();
  }
}