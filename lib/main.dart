import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/controller/cart_item.dart';
import 'package:e_commerce/controller/product_quantity.dart';
import 'package:e_commerce/screens/admin/edit_product.dart';
import 'package:e_commerce/controller/admin_provider.dart';
import 'package:e_commerce/screens/user/home_page.dart';
import 'package:e_commerce/screens/sign_up.dart';
import 'package:e_commerce/screens/user/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/admin_page.dart';
import 'package:e_commerce/screens/admin/add_product.dart';
import 'package:e_commerce/screens/admin/order_details.dart';
import 'package:e_commerce/screens/admin/manage_product.dart';
import 'package:e_commerce/screens/admin/edit_product.dart';
import 'package:e_commerce/screens/admin/view_orders.dart';
import 'package:e_commerce/screens/user/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 bool isUserLoggedIn = false ;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context , snapshot) {
        if (snapshot.hasData) {
          isUserLoggedIn = snapshot.data?.getBool(KkeepMeLoggedIn)?? false ;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<IsAdmin>(
                create: (context) => IsAdmin() ,

              ) ,
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem() ,
              ) ,
              ChangeNotifierProvider<QuantityProvider>(
                create: (context) => QuantityProvider() ,
              )
            ], child:MaterialApp(
            initialRoute: isUserLoggedIn ? HomePage.id:LoginScreen.id,
            routes: {
              LoginScreen.id :(context) => LoginScreen() ,
              SignUpScreen.id : (context) => SignUpScreen() ,
              HomePage.id : (context) => HomePage() ,
              AdminPage.id:(context) => AdminPage() ,
              AddProduct.id : (context) => AddProduct() ,
              ManageProduct.id: (context) => ManageProduct() ,
              ViewOrders.id : (context) => ViewOrders() ,
              EditProduct.id : (context) => EditProduct() ,
              ProductInfo.id :(context) => ProductInfo(),
              CartScreen.id : (context) => CartScreen () ,
              OrderDetails.id : (context) => OrderDetails() ,
            },

          ),
          ) ;
        }else {
          return const Center(child: Text('Loading...'),) ;
        }
      },
    );
  }
}
