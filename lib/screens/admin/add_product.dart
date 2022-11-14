import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/fire_store.dart';

class AddProduct extends StatelessWidget {
  static String id = ' AddProduct';
  final _store = FireStore();

  String? _name, _price, _description, _category, _location;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Page'),
        centerTitle: true,
        backgroundColor: kMainColor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: kMainColor,
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
          child: ListView(
            children:[ Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyTextField(
                  obsecured: false,
                  onClick: (value) {
                    _name = value;
                  },
                  hint: 'Product Name',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  obsecured: false,
                  onClick: (value) {
                    _price = value;
                  },
                  hint: 'Product Price',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  obsecured: false,
                  onClick: (value) {
                    _description = value;
                  },
                  hint: 'Product Description',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  obsecured: false,
                  onClick: (value) {
                    _category = value;
                  },
                  hint: 'Product Category',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  obsecured: false,
                  onClick: (value) {
                    _location = value;
                  },
                  hint: 'Product Location',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Builder(
                  builder: (context) =>
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kSecondaryColor,
                        ),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            _key.currentState!.save();
                            _store.addProduct(
                              Product(
                                PName: _name,
                                PPrice: _price,
                                PLocation: _location,
                                PCategory: _category,
                                PDescribtion: _description,
                              ),
                            );
                          }
                          if (_name!.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content:Text("Successfully add to firebase") ) );
                          }
                        },
                        child: const Text(
                          "Add Product",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                )
              ],
            )],
          ),
        ),
      ),
    );
  }
}
