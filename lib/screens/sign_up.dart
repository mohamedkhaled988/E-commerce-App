import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/controller/admin_provider.dart';
import 'package:e_commerce/screens/user/home_page.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static String id = "SignUpScreen";
  String? _email, _password , _name ;
  final _auth = Auth();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
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
                      ) ,
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              MyTextField(
                onClick: (value) {
                  _name = value ;
                },
                hint: 'Enter your name',
                icon: Icons.person,
                obsecured: false,
              ),
              SizedBox(
                height: height * .02,
              ),
              MyTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your e-mail',
                icon: Icons.email,
                obsecured: false,
              ),
              SizedBox(
                height: height * .02,
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

                      if (_globalKey.currentState!.validate()) {
                        _globalKey.currentState!.save();
                        try {
                          await _auth.signUp(_email!.trim(), _password!.trim());
                          Navigator.pushNamed(context, HomePage.id) ;
                        }on Exception  catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), ), );
                        }
                      }
                    },
                    child: const Text('SignUp'),
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
                    "Do have account ? ",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  GestureDetector(
                    child: const Text(
                      "LogIn",
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}
