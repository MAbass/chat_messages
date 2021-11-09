import 'package:chat_messages/mixins/mixins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with InputValidationMixin {
  bool _createNewAccount = false;
  final _formGlobalKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authData = {"email": "", "password": "", "username": ""};

  Future<void> _submit() async {
    if (!_formGlobalKey.currentState.validate()) {
      return;
    }
    _formGlobalKey.currentState.save();
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;
    print('Username: ${username}');
    print('Password: ${password}');
    print('Email: ${email}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Form for chat",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          if (_createNewAccount)
            TextFormField(
              decoration: InputDecoration(hintText: "Give your email address"),
              controller: _emailController,
              onSaved: (value) {
                _authData["email"] = value;
              },
              validator: (value) {
                if (isEmailValid(value))
                  return null;
                else
                  return 'Enter a valid email address';
              },
            ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Username"),
            controller: _usernameController,
            onSaved: (value) {
              _authData["username"] = value;
            },
            validator: (value) {
              if (isValidUsername(value))
                return null;
              else
                return 'Enter a valid username';
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Password"),
            controller: _passwordController,
            obscureText: true,
            onSaved: (value) {
              _authData["password"] = value;
            },
            validator: (value) {
              if (isPasswordValid(value))
                return null;
              else
                return 'Enter a valid password';
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: _submit,
              child: Text(_createNewAccount ? "Register" : "Login"),
              style: TextButton.styleFrom(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          TextButton(
              onPressed: () {
                setState(() {
                  _createNewAccount = !_createNewAccount;
                });
              },
              child: Text(
                _createNewAccount ? "Connect" : "Create a new account",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
