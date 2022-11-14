import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/fire_store.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = "OrderDetails";

  FireStore _store = FireStore();

  @override
  Widget build(BuildContext context) {
    Order? ordersId = ModalRoute.of(context)!.settings.arguments as Order?;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrderDetails(ordersId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data!.docs) {
              Map? data = doc.data() as Map?;
              products.add(Product(
                PName: data![KProductName],
                PQuantity: data![KProductQuantity],
                PCategory: data![KProductCategory],
              ));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .025,
                            horizontal:
                                MediaQuery.of(context).size.width * .04),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: kMainColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          height: MediaQuery.of(context).size.height * .18,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Product Name ${products[index].PName}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Quntity is ${products[index].PQuantity.toString()}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Product Category ${products[index].PCategory}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: kMainColor ,
                          ),
                          child: const Text("Confirm Order"),
                        ),
                      ),
                      const SizedBox(width: 15.0,) , 
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: kMainColor ,
                          ),
                          child: const Text("Delete Order"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text("Is Loading "),
            );
          }
        },
      ),
    );
  }
}
