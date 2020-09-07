import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/register_response.dart';
import 'package:chat/models/user.dart';

class AuthService with  ChangeNotifier {

  User user; 
  bool _logging = false;
  bool _registering = false;

  //Create storage
  final _storage = new FlutterSecureStorage();


  bool get logging  => this._logging;
  set logging(bool value){
    this._logging = value;
    notifyListeners();
  }
  bool get registering  => this._registering;
  set registering(bool value){
    this._registering = value;
    notifyListeners();
  }
  // Getters del token de forma estática.

  static Future<String> getToken()async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
    
  }
  static Future<void> deleteToken()async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
    
  }

  Future<bool> login( String email, String password ) async {

    this.logging = true;

    final data = {
      'email' : email,
      'password': password
    };

    final resp = await http.post('${ Environment.apiUrl }/login',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
      this.logging = false;

    if ( resp.statusCode == 200 ) {
     final loginResponse = loginResponseFromJson( resp.body );
      this.user = loginResponse.user;
      
      this._saveToken(loginResponse.token);
      return true;
    }else{
      return false;
    }
  }

  Future register( String name, String email, String password ) async {
    this.registering = true;
    final data = {
      'name' : name,
      'email': email,
      'password': password
    };
    final resp = await http.post('${ Environment.apiUrl }/login/new',
    body: jsonEncode(data),
    headers: {
      'Content-Type' : 'application/json'
      }
    );
    this.registering = false;
    if( resp.statusCode == 200 ){
      final registerResponse = registerResponseFromJson( resp.body );
      this.user = registerResponse.user;

      this._saveToken(registerResponse.token);
      return true;
    }else{
      final respBody = jsonDecode(resp.body);
      return respBody;
    }

  }

  Future<bool> isLoggedIn() async {
    
    final token = await this._storage.read(key: 'token');


    final resp = await http.get('${Environment.apiUrl}/login/renew',
      headers: {
        'Content-Type': 'application/json',
        'x-token' : token
      }
    );

    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await this._saveToken(loginResponse.token);

      return true;

    }else{
      this.logout();
      return false;
    }

  }



  Future _saveToken(String token) async {
      return await _storage.write(key: 'token', value: token);
  }
  Future logout() async {
      return await _storage.delete(key: 'token');
  }


}