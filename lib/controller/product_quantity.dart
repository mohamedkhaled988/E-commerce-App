import'package:flutter/material.dart' ;

class QuantityProvider extends ChangeNotifier {
  int quantity = 1 ;
  add () {
    quantity ++ ;
    notifyListeners() ;
  }
  subtract () {
    if (quantity > 1 ) {
      quantity -- ;
      notifyListeners() ;
    }
  }
}