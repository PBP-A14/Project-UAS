import 'package:elibrary/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  bool _isObscure1 = false;
  bool _isObscure2 = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/E-Lib.png',
                scale: 24,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('eLibrary'),
              ),
            ],
          ),
          scrolledUnderElevation: 0,
          centerTitle: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'Username',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _password1Controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure1 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure1 = !_isObscure1;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _password2Controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: 'Re-enter password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure2 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password1 = _password1Controller.text;
                    String password2 = _password2Controller.text;

                    if (username.isNotEmpty ||
                        password1.isNotEmpty ||
                        password2.isNotEmpty) {
                      if (password1 == password2) {
                        final response = await request.register(
                            "http://${baseUrl}authentication/mobile-register/",
                            {
                              'username': username,
                              'password': password1,
                            });
                        if (request.registered) {
                          if (mounted) {
                            String message = response['message'];
                            // String uname = response['username'];
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(message),
                              ));
                            Navigator.pop(context);
                          }
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xFFFFDCE0),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "Username already exist!",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              backgroundColor: Color(0xFFFFDCE0),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Password don't match!",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                      }
                    } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xFFFFDCE0),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Field can't be empty!",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                    }
                  },
                  child: const Text('Sign up'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Sign in'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
