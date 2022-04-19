import 'package:flutter/material.dart';

class IncController with ChangeNotifier {

  String x;
  String y;
  IncController({ this.x = '',  this.y = ''});

 final Map<String, dynamic> _shoppingCart = {};


  int get count => _shoppingCart.length;
  Map<String, dynamic> get cart => _shoppingCart;

  addItem(String op1, String op2, String op3){
    _shoppingCart.addAll({x : op1, y: op2, op3: op3});
    notifyListeners();
  }

}