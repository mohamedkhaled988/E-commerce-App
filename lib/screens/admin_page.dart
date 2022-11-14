import 'package:e_commerce/screens/admin/add_product.dart';
import 'package:e_commerce/screens//admin/manage_product.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/screens/admin/view_orders.dart';
import 'package:e_commerce/screens/user/home_page.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);
  static String id = "AdminPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
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
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kSecondaryColor ,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id) ;
              },
              child:const Text("Add Product" ,
              style: TextStyle(
                color: Colors.black ,
                fontWeight: FontWeight.bold ,
              ),
              ),
            ) ,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kSecondaryColor ,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(ManageProduct.id) ;
              },
              child:const Text("Edit Product" ,
              style: TextStyle(
                color: Colors.black ,
                fontWeight: FontWeight.bold ,
              ),
              ),
            ) ,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kSecondaryColor ,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ViewOrders.id) ;
              },
              child:const Text("View Orders" ,
              style: TextStyle(
                color: Colors.black ,
                fontWeight: FontWeight.bold ,
              ),
              ),
            ) ,
          ],
        ),
      ),
    );
  }
}
