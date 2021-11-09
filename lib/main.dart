import 'package:chat_messages/screen/AuthScreen.dart';
import 'package:chat_messages/screen/Chat.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
      routes: {
        ChatScreen.routeName: (_) => ChatScreen(),
        AuthScreen.routeName: (_) => AuthScreen(),
      },
    );
  }
}
