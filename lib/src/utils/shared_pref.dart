import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rent_finder/src/provider/users_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
   void save ( String key,  dynamic value) async {
     final prefs = await SharedPreferences.getInstance();
     final jsonString = json.encode(value);
     await prefs.setString(key, jsonString);
   }
   Future <dynamic> read (String key) async {
     final prefs = await SharedPreferences.getInstance();
     final jsonString = prefs.getString(key);
     if (jsonString == null) return null;
     return json.decode(jsonString);
   }
   Future<bool> contains ( String key) async {
     final prefs = await SharedPreferences.getInstance();
     return prefs.containsKey(key);
   }
   Future<bool> remove (String key ) async {
     final prefs = await SharedPreferences.getInstance();
     return prefs.remove(key);
   }

   void logout (BuildContext context, String idUser) async  {

     UsersProvider usersProvider = new UsersProvider();
     usersProvider.init(context!);
     await usersProvider.logout(idUser);
     await remove('user');
     Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);

}
}