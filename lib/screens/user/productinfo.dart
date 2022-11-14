import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/controller/cart_item.dart';
import 'package:e_commerce/controller/product_quantity.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/user/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = "ProductInfo";

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    Product? products = ModalRoute.of(context)!.settings.arguments as Product?;
    QuantityProvider provider = Provider.of<QuantityProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage(products!.PLocation!),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop;
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.id) ;
                    },
                    icon:const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Column(
              children: [
                Container(
                  color: Colors.white.withOpacity(0.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products.PName!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          products.PDescribtion!,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "\$${products.PPrice!}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: kMainColor,
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<QuantityProvider>(context,
                                            listen: false)
                                        .add();
                                  },
                                  child: const SizedBox(
                                    height: 28.0,
                                    width: 28.0,
                                    child:  Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              provider.quantity.toString(),
                              style: const TextStyle(
                                fontSize: 60.0,
                              ),
                            ),
                            ClipOval(
                              child: Material(
                                color: kMainColor,
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<QuantityProvider>(context,
                                            listen: false)
                                        .subtract();
                                  },
                                  child: const SizedBox(
                                    height: 28.0,
                                    width: 28.0,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .07,
                  child: Builder(
                    builder: (context) => ElevatedButton(
                      onPressed: () {
                        CartItem cartItem =
                            Provider.of<CartItem>(context, listen: false);
                        products.PQuantity = provider.quantity;
                        bool exist = false ;
                        var productsInCart = cartItem.products ;
                        for(var productInCart in productsInCart) {
                          if(productInCart.PName == products.PName) {
                            exist = true ;
                          }
                        }
                        if(exist) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("You have added this item before"),
                            ),
                          );
                        }else {
                          cartItem.addProduct(products);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to the cart"),
                          ),
                        );}

                      },
                      style: ElevatedButton.styleFrom(
                          primary: kMainColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0)))),
                      child: Text('Add to Cart'.toUpperCase()),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
