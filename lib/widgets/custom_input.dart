import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  
  @required final Icon prefixIcon;
  @required final String hintText;
  @required final bool obscureText;
  final TextInputType keyboardType;
  @required final TextEditingController textController;


  CustomInput({
    @required this.prefixIcon, 
    @required this.hintText, 
    @required this.obscureText, 
    this.keyboardType = TextInputType.text, 
    @required this.textController
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:20),
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyboardType,
          obscureText: this.obscureText,
        decoration: InputDecoration(
            prefixIcon: this.prefixIcon,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: this.hintText,
        ),
      ),
    );
  }
}
