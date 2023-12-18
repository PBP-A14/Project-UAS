import 'package:elibrary/navigation_menu.dart';
import 'package:elibrary/pages/authentication/login_user.dart';
import 'package:elibrary/pages/authentication/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../auth/auth.dart';

class PasswordFormPage extends StatefulWidget {
  static const routeName = '/login';

  const PasswordFormPage({super.key});

  @override
  State<PasswordFormPage> createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {
  TextEditingController _old_passwordController = TextEditingController();
  TextEditingController _new_password1 = TextEditingController();
  TextEditingController _new_password2 = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop;
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/E-Lib.png',
                  scale: 24,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Change Password'),
                ),
              ],
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Text(
                  'Change your password here',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Text('Fill all the fields'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    controller: _old_passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'Old Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    controller: _new_password1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'New Password',
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
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    controller: _new_password2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'Re-renter new Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure3 ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure3 = !_isObscure3;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure3,
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
                    // onPressed: () {
                    //   Navigator.pushReplacementNamed(context, NavigationMenu.routeName);
                    // },
                    onPressed: () async {
                      String old_password = _old_passwordController.text;
                      String new_password1 = _new_password1.text;
                      String new_password2 = _new_password2.text;

                      if (old_password.isNotEmpty ||
                          new_password1.isNotEmpty ||
                          new_password2.isNotEmpty) {
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        final response = await request.post(
                            "http://127.0.0.1:8000/my_profile/change_password_mobile/",
                            {
                              'old_password': old_password,
                              'new_password1': new_password1,
                              'new_password2': new_password2,
                            });

                        if (response['status'] == true) {
                          String message = response['success'];
                          // print(CurrUserData.user_id);
                          // print(CurrUserData.username);
                          if (mounted) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("$message.")));
                            Navigator.pop(context);
                          }
                        } else {
                          if (mounted) {
                            _old_passwordController.clear();
                            _new_password1.clear();
                            _new_password2.clear();
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xFFFFDCE0),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    """Old Password is wrong or New Passwor didn't meet the requirements!\nPlease try again!\n
                                    Requirements:\n
                                    1. Password must be at least 8 characters.\n
                                    2. Password must contain at least 1 number.\n """,
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
                                "Fields can't be empty!",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                      }
                    },
                    child: const Text('Change Password'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
