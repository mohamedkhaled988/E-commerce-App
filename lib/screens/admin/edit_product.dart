import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/fire_store.dart';
import 'package:e_commerce/widgets/text_field.dart';
import 'package:flutter/material.dart';
class EditProduct extends StatelessWidget {

static String id= "EditProduct" ;

  final _store = FireStore();

  String? _name, _price, _description, _category, _location;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Product? products = ModalRoute.of(context)!.settings.arguments as Product?  ;
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Page'),
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
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextField(
              obsecured: false,
              onClick: (value) {
                _name = value;
              },
              hint: 'Product Name ',
            ),
            const SizedBox(
              height: 10.0,
            ),
            MyTextField(
              obsecured: false,
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price ',
            ),
            const SizedBox(
              height: 10.0,
            ),
            MyTextField(
              obsecured: false,
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description ',
            ),
            const SizedBox(
              height: 10.0,
            ),
            MyTextField(
              obsecured: false,
              onClick: (value) {
                _category = value;
              },
              hint: 'Product Category ',
            ),
            const SizedBox(
              height: 10.0,
            ),
            MyTextField(
              obsecured: false,
              onClick: (value) {
                _location = value;
              },
              hint: 'Product Location ',
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kSecondaryColor,
              ),
              onPressed: () {
                if (_key.currentState!.validate()) {
                  _key.currentState!.save();
                  _store.editProduct(({
                    KProductName : _name ,
                    KProductprice : _price ,
                    KProductCategory: _category ,
                    KProductDescription: _description ,
                    KProductLocation : _location ,
                  }), products!.PId) ;
                }
              },
              child: const Text(
                "Add Product",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
