import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:userdetails/service/auth_service.dart';
import 'package:userdetails/utils/toasts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                "Sign up",
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
                      await AuthServiceHelper.createAccountWithEmail(
                              emailcontroller.text, passwordcontroller.text)
                          .then((value) {
                        if (value == "Account Created") {
                          Message.show(message: "Account Created");
                          Navigator.pushNamed(context, '/home');
                        } else {
                          Message.show(message: "Error: $value");
                        }
                      });
                    },
                    child: Text("Sign up")),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Already have an Account"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
