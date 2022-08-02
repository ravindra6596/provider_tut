import 'package:flutter/material.dart';

class ColorStatusState extends ChangeNotifier {
  var numberOfClicks = 0;
  Color buttonColor = Colors.red;

  void changeColor() {
    numberOfClicks++;
    numerOfClicksToColor(numberOfClicks);
    notifyListeners();
  }

  numerOfClicksToColor(int num) {
    switch (num) {
      case 1:
        buttonColor = Colors.orange;
        break;
      case 2:
        buttonColor = Colors.green;
        break;
      default:
        buttonColor = Colors.red;
        numberOfClicks=0;
        break;
    }
    notifyListeners();
  }
}
