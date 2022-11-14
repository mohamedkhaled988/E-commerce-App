import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  List <Product> products = [] ;

  addProduct (Product product) {
    products.add(product) ;
    notifyListeners() ;
  }
  deleteProduct (Product product) {
    products.remove(product) ;
    notifyListeners() ;
  }
}