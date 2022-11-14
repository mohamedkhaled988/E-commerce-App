import 'package:e_commerce/constants/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
   IconData? icon;
   bool? obsecured ;
   var onClick  ;
  String? _errorMethod (String str) {
    switch(str){
      case 'Enter your name'  : return 'Name is empty!' ;
      case 'Enter your e-mail' : return 'E-mail is empty!' ;
      case 'Enter your password'  : return 'Password is empty!' ;
      case 'Product Name'  : return 'Product Name is empty!' ;
      case 'Product Price'  : return 'Product Price is empty!' ;
      case 'Product Description'  : return 'Product Description is empty!' ;
      case 'Product Category'  : return 'Product Category is empty!' ;
      case 'Product Location'  : return 'Product Location is empty!' ;
    }
  }

  MyTextField({required this.hint,required this.onClick ,  this.icon , required this.obsecured});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * .1),
      child: TextFormField(
        onSaved:onClick,
        validator: (String? value) {
          if (value!.isEmpty){
            return _errorMethod(hint) ;
          }
          return null;
        },
        cursorColor: kMainColor,
        obscureText: obsecured!,
        decoration: InputDecoration(
          filled: true,
          fillColor: kSecondaryColor,// عشان يديه لون من جوه
          enabledBorder: OutlineInputBorder( // عشان يعمل شكل المستطيل ويديه حدود وكده
            borderRadius: BorderRadius.circular(20.0) ,
            borderSide:const BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder( // عشان لما اضغط عليه يفضل نفس الشكل زي في اللي فات
              borderRadius: BorderRadius.circular(20.0) ,
              borderSide:const BorderSide(color: Colors.white)
          ),
          border: OutlineInputBorder(
            // if there is an error it will keep the UI as it is
              borderRadius: BorderRadius.circular(20.0) ,
              borderSide:const BorderSide(color: Colors.red , width: 2.0)
          ),
          hintText: hint ,
          prefixIcon: Icon(icon , color: kMainColor,) ,
        ),
      ),
    );
  }
}
