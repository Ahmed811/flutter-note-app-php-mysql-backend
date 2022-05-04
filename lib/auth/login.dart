import 'package:flutter/material.dart';
import 'package:notapp_backend/components/connect.dart';
import 'package:notapp_backend/components/custom_text_form.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../components/valid.dart';
import '../constant/api_link.dart';
import '../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  Connect _connect = Connect();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Lottie.asset(
                    'assets/notebook.json',
                    fit: BoxFit.cover,
                    height: 200,
                    width: 250,
                    animate: true,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Form(
                      key: formstate,
                      child: Column(
                        children: [
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                            textEditingController: email,
                            hint: "email",
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                            textEditingController: password,
                            hint: "password",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            onPressed: () async {
                              await login();
                            },
                            color: Colors.blue,
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("signup");
                              },
                              child: Text("signup"))
                        ],
                      ))
                ],
              ),
      ),
    );
  }

  login() async {
    // if (formstate.currentState!.validate()) {
    isLoading = true;
    setState(() {});
    var response = await _connect.postRequest(
        linkLogin, {"email": email.text, "password": password.text});
    isLoading = false;
    setState(() {});
    if (response["status"] == "success") {
      sharedPref.setString("id", response["userdata"]["id"].toString());
      sharedPref.setString(
          "username", response["userdata"]["username"].toString());
      sharedPref.setString("email", response["userdata"]["email"].toString());
      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    } else {
      AwesomeDialog(
          btnCancel: Text("Cancel"),
          context: context,
          title: "تنبيه",
          body: Text(
              "البريد الالكتروني تو كلمة المرور خاطئة او الحساب غير موجود"))
        ..show();
    }
  }
}
