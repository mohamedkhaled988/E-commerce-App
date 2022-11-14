import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/functions.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/user/cart_screen.dart';
import 'package:e_commerce/screens/user/productinfo.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/fire_store.dart';
import 'package:e_commerce/widgets/product_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

final _store = FireStore();

final _auth = Auth();
int _tabBarIndex = 0;
int _navIndex = 0;

List<Product> _products = [];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _navIndex,
              fixedColor: kMainColor,
              onTap: (val) async{
                if(val == 2 ) { // to sign out
                  SharedPreferences pref = await SharedPreferences.getInstance() ;
                  pref.clear() ;
                  await _auth.signOUt() ;
                  Navigator.of(context).popAndPushNamed(LoginScreen.id) ;
                }
                setState(() {
                  _navIndex = val;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  label: "Person",
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: "Person",
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: "Sign Out",
                  icon: Icon(Icons.close),
                ),

              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (index) {
                  setState(() {
                    _tabBarIndex = index;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Jackets',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16.0 : null,
                    ),
                  ),
                  Text(
                    'Trousers',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16.0 : null,
                    ),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16.0 : null,
                    ),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16.0 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacketView(),
                productView(KTrousers, _products),
                productView(KShoes, _products),
                productView(KTshirts, _products),
              ],
            ),
          ),
        ),
        Material(
          // بتساعد الcontainer يبقي ليها theme لوحدها
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "DISCOVER",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.id);
                    },
                    icon: const Icon(
                      (Icons.shopping_cart),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = <Product>[];
          for (var doc in snapshot.data!.docs) {
            Map? data = doc.data() as Map?;
            products.add(
              Product(
                  PName: data![KProductName],
                  PPrice: data![KProductprice],
                  PLocation: data![KProductLocation],
                  PDescribtion: data![KProductDescription],
                  PCategory: data![KProductCategory],
                  PId: doc.id),
            );
          }
          _products = [
            ...products
          ]; // الحركة دي اسمها spread operator كده الليست الاتنين مستقلين عن بعض
          // هتاخد الداتا بتاعتها بعدين ملهاش دعوة بيها لما يحصلها clear
          products.clear();
          products = getProductByCat(KJackets, _products);
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
        } else {
          return const Center(
            child: Text('Loading....'),
          );
        }
      },
    );
  }
}
