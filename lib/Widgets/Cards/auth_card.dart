import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Screens/menu_screen.dart';
import 'package:provider/provider.dart';

import '../../Providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final double _heightMax = 390.0;
  final double _heightMin = 300.0;
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;
  var _isEmailValid = false;
  var _isPasswordValid = false;
  var _isConfirmValid = false;
  var _buttonState = false;

  late AnimationController _controller;
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': 'null',
    'password': 'null',
  };

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isValidInput() {
    if (_authMode == AuthMode.Login) return _isEmailValid && _isPasswordValid;
    if (_authMode == AuthMode.Signup){
      return _isEmailValid && _isPasswordValid && _isConfirmValid;
    }
    return false;
  }

  void _showDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title, style: Theme.of(context).textTheme.bodyText2,),
            content: Text(content , style: Theme.of(context).textTheme.subtitle1),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay')),
            ],
          );
        });
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    bool signUpSuccess = true;
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email']!, _authData['password']!);
        log('SIGN IN:');
        if (Provider.of<Auth>(context).isAuth){
          Navigator.of(context).pushNamed(MenuScreen.routeName);
        }
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!)
            .catchError((error) {
          var errorMessage = error.toString();
          if (errorMessage.contains('EMAIL_EXISTS')) {
            errorMessage = 'This email is already in use';
          }
          signUpSuccess = false;
          _showDialog('An error occurred', errorMessage);
        });
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed. ${error.toString()}';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email is already in use';
      }
      _showDialog('An error occurred', errorMessage);
    } catch (error) {
      _showDialog(
          'An error occurred', 'Could not authenticate you. Try again later.');
    }
    if (_authMode == AuthMode.Signup && signUpSuccess) {
      setState(() {
        _switchAuthMode();
        _passwordController.clear();
      });
      _showDialog('Signup successful', 'Press Okay to continue');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _authMode == AuthMode.Signup ? _heightMax : _heightMin,
        constraints: BoxConstraints(
            minHeight: _authMode == AuthMode.Signup ? _heightMax : _heightMin),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: _authMode == AuthMode.Signup
                  ? _heightMax - 30
                  : _heightMin - 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'E-Mail', fillColor: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => _validateEmail(value),
                        style: Theme.of(context).textTheme.headline5,
                        onSaved: (value) {
                          _authData['email'] = value!;
                        },
                        onChanged: (_) => _checkIfButtonChanged(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) => _validatePassword(value),
                        style: Theme.of(context).textTheme.headline5,
                        onSaved: (value) {
                          _authData['password'] = value!;
                        },
                        onChanged: (_) => _checkIfButtonChanged(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (_authMode == AuthMode.Signup)
                        TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value) => _validateSignupPassword(value),
                          style: Theme.of(context).textTheme.headline5,
                          onChanged: (_) => _checkIfButtonChanged(),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        MaterialButton(
                          onPressed: _buttonState ? _submit : null,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          textColor: Theme.of(context).textTheme.button!.color,
                          child: Text(_authMode == AuthMode.Login
                              ? 'LOGIN'
                              : 'SIGN UP'),
                        ),
                      const SizedBox(
                        height: 4,
                      ),
                      MaterialButton(
                        onPressed: _switchAuthMode,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: Theme.of(context).textTheme.button?.color,
                        child: Text(
                            '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(value) {
    if (value.isEmpty) {
      _isEmailValid = false;
      return null;
    }
    if (!value.contains('@')) {
      return 'Invalid email!';
    }
    _isEmailValid = true;
    return null;
  }

  String? _validatePassword(value) {
    if (value.isEmpty) {
      _isPasswordValid = false;
      return null;
    }
    if (value.length <= 6) {
      _isPasswordValid = false;
      return 'Password is too short!';
    }
    _isPasswordValid = true;
    return null;
  }

  String? _validateSignupPassword(value) {
    if (_authMode == AuthMode.Signup) {
      if (value.isEmpty) {
        _isConfirmValid = false;
        return null;
      }
      if (value != _passwordController.text) {
        _isConfirmValid = false;
        return 'Passwords do not match!';
      }
      _isConfirmValid = true;
      return null;
    }
    return null;
  }

  void _checkIfButtonChanged() {
    _formKey.currentState?.validate();
    if (_buttonState != _isValidInput()) {
      setState(() {
        _buttonState = _isValidInput();
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        _resetToFalse();
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _passwordController.clear();
        _resetToFalse();
      });
      _controller.reverse();
    }
  }

  void _resetToFalse() {
    _isEmailValid = false;
    _isPasswordValid = false;
    _isConfirmValid = false;
    _buttonState = false;
  }
}
