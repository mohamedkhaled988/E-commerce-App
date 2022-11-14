import 'package:flutter/material.dart';

class IsAdmin with ChangeNotifier {
  bool isAdmin  = false ;
  changeAdmin  (bool value ) {
    isAdmin = value ;
    notifyListeners() ;
  }
}