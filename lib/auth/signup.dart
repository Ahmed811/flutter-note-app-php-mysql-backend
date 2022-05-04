import 'package:flutter/material.dart';
import 'package:notapp_backend/components/connect.dart';
import 'package:notapp_backend/components/custom_text_form.dart';
import 'package:lottie/lottie.dart';
import 'package:notapp_backend/constant/api_link.dart';

import '../components/valid.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Connect _connect = Connect();
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(
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
                              return validInput(val!, 3, 5);
                            },
                            textEditingController: username,
                            hint: "username",
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 3, 8);
                            },
                            textEditingController: email,
                            hint: "email",
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 3, 10);
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
                              //Todo add valadtion
                              // if (formstate.currentState!.validate()) {
                              await signUp();
                            },
                            color: Colors.blue,
                            child: Text(
                              "signup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("login");
                              },
                              child: Text("Login"))
                        ],
                      ))
                ],
              ),
            ),
    );
  }

  signUp() async {
    print("hi");

    setState(() {
      isLoading = true;
    });
    try {
      var response = await _connect.postRequest(linkSignup, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      print("response is=============$response");

      setState(() {
        isLoading = false;
      });

      if (response["status"] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("signup failed");
      }
    } catch (e) {
      print(e);
    }
  }
}
