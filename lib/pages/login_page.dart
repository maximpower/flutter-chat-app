import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/blue_button.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_label.dart';
import 'package:chat/widgets/login_register_logo.dart';
import 'package:provider/provider.dart';


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

     final AuthService authService = Provider.of<AuthService>( context );

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
           
                      
          BlueButton(
            textButton: 'Login',
            onPressed: authService.logging ? null : () async {
              
              FocusScope.of(context).unfocus();
              
             final loginOk = await authService.login(emailController.text.trim(), passwordController.text.trim());


              if( loginOk ){
                //Conectar a nuestro socket server.
                
                // ToDo Navegar a otra pantalla.
                Navigator.pushReplacementNamed(context, 'users');
              }else{
                // Mostrar alerta
                showAlert(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');

              }

            }
          )

         ],
       ),
    );
  }
}
