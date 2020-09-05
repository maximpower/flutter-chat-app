import 'package:chat/widgets/blue_button.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_label.dart';
import 'package:chat/widgets/login_register_logo.dart';


class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                
                LoginRegisterLogo(
                  logo: AssetImage('assets/images/tag-logo.png'),
                  text: 'Messenger',
                  width: 170,
                  fontSize: 30,
                ),

                _Form(),

                CustomLabel(
                  labelText: "You don't have an account?",
                  fontColor: Colors.black54,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                  route: 'register',
                  navigationText: 'Create an account',
                ),


                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)


              ],
            ),
          ),
        ),
      )
   );
  }
}


class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:40),
      padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column(
         children: <Widget>[
           
           CustomInput(
             hintText: 'Email', 
             obscureText: false,
             prefixIcon: Icon(Icons.email),
             keyboardType: TextInputType.emailAddress, 
             textController: emailController
           ),
           CustomInput(
             hintText: 'Password', 
             obscureText: true,
             prefixIcon: Icon(Icons.lock), 
             textController: passwordController,
           ),
           
          
          //TODO: Crear botón
            
          BlueButton(
            textButton: 'Login',
            onPressed: null,
          )

         ],
       ),
    );
  }
}
