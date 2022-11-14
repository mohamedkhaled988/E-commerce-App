import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';
List<Product> getProductByCat(String kJackets , List<Product> allProducts) {
  List<Product> prods = [] ;
  try{
    for(var product in allProducts) {
      if(product.PCategory == KJackets){
        prods.add(product) ;
      }
    }
  } on Error catch(e) {
    print(e) ;
  }
  return prods ;
}