import 'package:e_commerce/functions.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/user/productinfo.dart';
import 'package:flutter/material.dart';

productView(String PCategory, List<Product> allProducts) {
  List<Product> products = [];
  products = getProductByCat(PCategory, allProducts);
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductInfo.id,
                  arguments: products[index]);
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image(
                    image: AssetImage(products[index].PLocation!),
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    color: Colors.white.withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].PName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("\$ ${products[index].PPrice}"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
