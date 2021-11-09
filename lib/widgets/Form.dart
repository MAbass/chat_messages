import 'package:chat_messages/mixins/mixins.dart';
import 'package:chat_messages/screen/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with InputValidationMixin, FirebaseMixin {
  bool _isLoading = false;
  bool _createNewAccount = false;
  final _formGlobalKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authData = {"email": "", "password": "", "username": ""};

  Future<void> _submit() async {
    final isValid = _formGlobalKey.currentState.validate();
    _formGlobalKey.currentState.save();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        if (_createNewAccount) {
          print('Trying to create an user!!');
          await createUser(
              _authData['email'], _authData['username'], _authData['password']);
        } else {
          print('Trying to login an user!!');
          await login(_authData['email'], _authData['password']);
          Navigator.pushReplacementNamed(context, ChatScreen.routeName);
        }
      } catch (error) {
        print(error);
        var _message = "An error is occured!!";
        if(error.toString().contains("There is no user record corresponding to this identifier.")){
          _message = "There is no user record corresponding to this identifier.";
        }
        if(error.toString().contains("The password is invalid or the user does not have a password.")){
          _message = "The password is invalid or the user does not have a password";
        }
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("Error Dialog"),
                content: Text("Error:${_message}"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Okay"))
                ],
              );
            });
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
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
                  decoration:
                      InputDecoration(hintText: "Give your email address"),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _createNewAccount = !_createNewAccount;
                      });
                    },
                    child: Text(
                      _createNewAccount ? "Connect" : "Create a new account",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          );
  }
}
