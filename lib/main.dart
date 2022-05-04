import 'package:flutter/material.dart';
import 'package:notapp_backend/auth/login.dart';
import 'package:notapp_backend/auth/signup.dart';
import 'package:notapp_backend/home.dart';
import 'package:notapp_backend/notes/add.dart';
import 'package:notapp_backend/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/success.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Notes",
      initialRoute: sharedPref.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => Login(),
        "signup": (context) => Signup(),
        "success": (context) => Success(),
        "home": (context) => Home(),
        "add": (context) => Add(),
        // "edit": (context) => Edit()
      },
    );
  }
}
