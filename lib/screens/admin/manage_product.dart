import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/admin/edit_product.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/admin/manage_product.dart';
import 'package:e_commerce/widgets/custom_menue.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/fire_store.dart';

class ManageProduct extends StatefulWidget {
  static String id = "ManageProduct";
  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = FireStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: const Text('Edit Product Page'),
        centerTitle: true,
        backgroundColor: kMainColor,
        elevation: 0.0,
        leading: IconButton(
          icon:const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop() ;
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = <Product>[];
            for (var doc in snapshot.data!.docs) {
              Map? data = doc.data() as Map? ;
              products.add(
                Product(
                  PName: data![KProductName] ,
                  PPrice: data[KProductprice] ,
                  PLocation: data[KProductLocation] ,
                  PDescribtion: data[KProductDescription] ,
                  PCategory: data[KProductCategory] ,
                  PId: doc.id
                ),
              );
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10.0),
                    child: GestureDetector(
                      onTapUp: (details) {
                        double dxx = details.globalPosition.dx;
                        double dyy = details.globalPosition.dy;
                        double dxx2 = MediaQuery.of(context).size.width - dxx;
                        double dyy2 = MediaQuery.of(context).size.width - dyy;
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dxx, dyy, dxx2, dyy2),
                          items: [
                            MyPopupMenueItem(
                              child: const Text('Edit'),
                              onClick: () {
                                Navigator.pushNamed(context, EditProduct.id , arguments:products[index]) ;
                              },
                            ),
                            MyPopupMenueItem(
                              onClick: () {
                                _store.deleteProduct(products[index].PId) ;
                                Navigator.pop(context) ;
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
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
          } else {
            return const Center(
              child: Text('Loading....'),
            );
          }
        },
      ),
    );
  }
}


