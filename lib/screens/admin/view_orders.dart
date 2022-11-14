import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/screens/admin/order_details.dart';
import 'package:e_commerce/services/fire_store.dart';
import 'package:flutter/material.dart';

class ViewOrders extends StatelessWidget {
  static String id = "ViewOrders";

  final FireStore _store = FireStore();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Order> orders = [];
            for (var doc in snapshot.data!.docs) {
              Map? data = doc.data() as Map?;
              orders.add(
                Order(
                  docId: doc.id ,
                  address: data![KAddress],
                  totalPrice: data![KTotalPrice],
                ),
              );
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * .025,
                      horizontal: screenWidth * .04),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(OrderDetails.id , arguments: orders[index].docId!);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: kMainColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      height: screenHeight * .18,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Price = \$ ${orders[index].totalPrice}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Address is \$ ${orders[index].address}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "there is no Data yet!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
