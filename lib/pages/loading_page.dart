import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(child: CircularProgressIndicator());
        }
      )
    );
  }

  Future checkLoginState( BuildContext context ) async{

    final authService = Provider.of<AuthService>(context, listen:false);

    final logedIn = await authService.isLoggedIn();
    
    if(logedIn){
      Navigator.pushReplacementNamed(context, 'users');
    }else{
      Navigator.pushReplacementNamed(context, 'login');
    }

  }



}
