import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  
  final Function onPressed;
  final String textButton;

  const BlueButton({
    Key key, 
    @required this.onPressed, 
    @required this.textButton
  }) : super(key: key);




  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
          width: double.infinity,
          height: 55.0,
          child: Center(
            child: Text(
              this.textButton,
              style: TextStyle(
                color: Colors.white, 
                fontSize: 17
              )
            ),
          )),
    );
  }
}
