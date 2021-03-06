import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


showAlert( BuildContext context, String title, String subtitle){
  if(!Platform.isAndroid){
  return showDialog(
    context: context,
    builder: ( _ ) => AlertDialog(
      title: Text( title ),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          textColor: Colors.blue,
          child: Text('Ok'),
          elevation: 5,
          onPressed: () => Navigator.pop(context),
        )
      ]
    ),
  );
  }else{
  showCupertinoDialog(
    context: context,
    builder: ( _ ) => CupertinoAlertDialog(
      title: Text(title),
      content: Container(
        margin: EdgeInsets.only(top: 15),
        child: Text(subtitle)
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    )
  );
  }
}
