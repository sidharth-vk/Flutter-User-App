import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:userdetails/firebase_options.dart';
import 'package:userdetails/service/auth_service.dart';
import 'package:userdetails/ui/auth/login_screen.dart';
import 'package:userdetails/ui/auth/signup_screen.dart';
import 'package:userdetails/ui/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: LoginScreen(),
      routes: {
        "/": (context) => CheckUser(),
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignupScreen(),
        "/home": (context) => Home(),
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    AuthServiceHelper.isUserLoggedIn().then((value) {
      if (value == true) {
        Navigator.pushReplacementNamed(context, "/name");
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
