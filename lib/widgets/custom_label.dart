import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String labelText;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final String route;
  final String navigationText;

  const CustomLabel(
      {Key key,
      @required this.labelText,
      this.fontSize = 14,
      this.fontColor = Colors.black,
      this.fontWeight = FontWeight.normal,
      @required this.route,
      this.navigationText
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            this.labelText,
            style: TextStyle(
                color: this.fontColor,
                fontSize: this.fontSize,
                fontWeight: this.fontWeight),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context,  route),
            child: Text(
              this.navigationText,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),

        ],
      ),
    );
  }
}
