import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/controller/admin_provider.dart';
import 'package:e_commerce/screens/user/home_page.dart';
import 'package:e_commerce/screens/admin_page.dart';
import 'package:e_commerce/screens/sign_up.dart';
import 'package:e_commerce/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = "loginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? _email, _password;
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final adminPassword = "admin1234";
  final adminEmail = "admin1@gmail.com";
  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    IsAdmin provider = Provider.of<IsAdmin>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/buy.png'),
                    ),
                    Positioned(
                      bottom: 5.0,
                      child: Text(
                        'Buy Here',
                        style: GoogleFonts.pacifico(fontSize: 25.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
            MyTextField(
              onClick: (value) {
                _email = value;
              },
              hint: 'Enter your e-mail',
              icon: Icons.email,
              obsecured: false,
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: kMainColor,
                      value: keepMeLoggedIn,
                      onChanged: (val) {
                        setState(() {
                          keepMeLoggedIn = val!;
                        });
                      }) ,
                 const Text("Remember me " , style: TextStyle(
                    color: Colors.white ,fontSize: 18 ,
                  ),)
                ],
              ),
            ),
            MyTextField(
              onClick: (value) {
                _password = value;
              },
              hint: 'Enter your password',
              icon: Icons.lock,
              obsecured: true,
            ),
            SizedBox(
              height: height * .02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .27),
              child: Builder(
                builder: (context) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                  onPressed: () async {
                    if(keepMeLoggedIn == true) {
                      keepUserLoggedIn () ;
                    }
                    _validate(context);
                  },
                  child: const Text('Login'),
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account ? ",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                GestureDetector(
                  child: const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.id);
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Provider.of<IsAdmin>(context, listen: false).changeAdmin(true);
                    },
                    child: Text(
                      " I am admin",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: provider.isAdmin ? kMainColor : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<IsAdmin>(context,
                                listen: false) // لازم تخلي listen: false
                            .changeAdmin(false);
                      },
                      child: Text(
                        "I am user",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: provider.isAdmin ? Colors.white : kMainColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      // so the data coming from textfield will be stored in email & password
      if (Provider.of<IsAdmin>(context, listen: false).isAdmin) {
        if (_password == adminPassword && _email == adminEmail) {
          try {
            await _auth.signIn(_email!, _password!);
            Navigator.pushNamed(context, AdminPage.id);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong")),
          );
        }
      }
      else {
        try {
          await _auth.signIn(_email!, _password!);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }

  void keepUserLoggedIn() async{
    SharedPreferences pref = await SharedPreferences.getInstance() ;
    pref.setBool(KkeepMeLoggedIn, keepMeLoggedIn) ;

  }
}
