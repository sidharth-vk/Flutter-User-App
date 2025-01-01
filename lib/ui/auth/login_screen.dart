import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:userdetails/service/auth_service.dart';
import 'package:userdetails/utils/toasts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    hintText: "Enter your Email"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    hintText: "Enter your Password"),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                    onPressed: () async {
                      await AuthServiceHelper.loginWithEmail(
                              emailcontroller.text, passwordcontroller.text)
                          .then((value) {
                        if (value == "Login Successfull") {
                          Message.show(message: "Login Successfull");
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          Message.show(message: "Error : $value");
                        }
                      });
                    },
                    child: Text("Sign In")),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Need an Account"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text("Register"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
