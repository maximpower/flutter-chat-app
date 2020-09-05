import 'package:flutter/material.dart';

class LoginRegisterLogo extends StatelessWidget {

  final double width;
  final ImageProvider  logo;
  final String  text;
  final double  fontSize;

  const LoginRegisterLogo({
    Key key, 
    @required this.width, 
    @required this.logo, 
    @required this.text,
    this.fontSize = 15
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.width,
        child: Column(
          children: <Widget>[
            Image(image: logo),
            // Image(image: AssetImage('assets/images/tag-logo.png')),
            SizedBox(height: 20),
            Text(
              this.text,
              style: TextStyle(fontSize: this.fontSize),
            )
            // Text('Messenger', style: TextStyle(fontSize: 30.0)),
          ]
        ),

      ),
    );
  }
}
