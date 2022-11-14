import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/controller/cart_item.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/user/cart_screen.dart';
import 'package:e_commerce/screens/user/productinfo.dart';
import 'package:e_commerce/services/fire_store.dart';
import 'package:e_commerce/widgets/custom_menue.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = "CartScreen";

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false, // عشان لو عملت alertdialog ميديش خطأ
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    (screenHeight * .07 + appBarHeight + statusBarHeight),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context, products[index]);
                        },
                        child: Container(
                          height: screenHeight * .14,
                          color: kMainColor,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: screenHeight * .14 / 2,
                                backgroundImage:
                                    AssetImage(products[index].PLocation!),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.04),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            products[index].PName!,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "\$ ${products[index].PPrice}",
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth * 0.04),
                                      child: Text(
                                        products[index].PQuantity!.toString(),
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                height: screenHeight -
                    (screenHeight * .07 + appBarHeight + statusBarHeight),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/emptyCart.png'),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Cart is empty',
                        style: GoogleFonts.pacifico(fontSize: 25.0),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
          Builder(
            builder:(context) =>  SizedBox(
              width: screenWidth,
              height: screenHeight * .07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kMainColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    )),
                onPressed: () {
                  showCustomDialog(products, context);
                },
                child: const Text("OREDER"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dxx = details.globalPosition.dx;
    double dyy = details.globalPosition.dy;
    double dxx2 = MediaQuery.of(context).size.width - dxx;
    double dyy2 = MediaQuery.of(context).size.width - dyy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dxx, dyy, dxx2, dyy2),
      items: [
        MyPopupMenueItem(
          child: Text('Edit'),
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
            Navigator.pushNamed(context, ProductInfo.id, arguments: product);
          },
        ),
        MyPopupMenueItem(
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    var adress ;
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
            onPressed: () {
              try {
                FireStore _store= FireStore() ;
                _store.storeOrders({
                  KTotalPrice : price  , KAddress : adress ,
                }, products) ;
                Navigator.of(context).pop() ;
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("added to firebase"))) ;
              } catch (e) {
                print(e) ;
              }
            },
            child: const Text('Confirm'),
          ),
      ],
      content:  TextField(
        onChanged: (val) {
          adress = val ;
        },
        decoration: InputDecoration(hintText: 'Enter your address'),
      ),
      title: Text('Total Price is \$ ${price}'),
    );
    await showDialog(context: context, builder: (context) => alertDialog);
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.PQuantity! * int.parse(product.PPrice!);
    }
    return price;
  }
}
