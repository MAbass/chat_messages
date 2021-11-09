import 'package:chat_messages/widgets/Form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = "auth-screen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          color: Colors.white,
          width: 350,
          height: 400,
          child: Container(padding: EdgeInsets.all(7), child: AuthForm()),
        ),
      ),
    );
  }
}
