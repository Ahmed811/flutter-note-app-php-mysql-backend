import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "تم انشاء الحساب بنجاح،الان يمكنك تسجيل الدخول",
              style: TextStyle(fontSize: 20),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              child: Text("تسجيل الدخول"),
            )
          ],
        ),
      )),
    );
  }
}
