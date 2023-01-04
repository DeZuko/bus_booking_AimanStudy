import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytest/widgets/constant_widget.dart';
import 'package:mytest/pages/authentication/shared_preferences.dart';
import 'package:mytest/models/user.dart';
import 'package:mytest/database/database_service.dart';
import 'package:mytest/database/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Database db = Provider.of<DbProvider>(context).db;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Spacing

                const SizedBox(
                  height: 50,
                ),

                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(3 * 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        Text(
                          'Please sign in to continue.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color.fromARGB(255, 181, 177, 177),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(3 * 16, 0, 3 * 16, 3 * 16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: username,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                              ),
                            ),
                            hintText: 'Username',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                            prefixIcon: Icon(Icons.person),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 50,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username.';
                            } else {
                              return null;
                            }
                          },
                        ),

                        //Spacing
                        gaphr(h: 16),

                        //Password Input
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          obscuringCharacter: '*',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                            prefixIcon: Icon(Icons.lock),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 50,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password.';
                            } else {
                              return null;
                            }
                          },
                        ),

                        //Spacing
                        gaphr(h: 50),

                        //Login Button

                        Container(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton(
                            child: const Text('Login'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic result =
                                    await DatabaseServices(db: db).login(
                                  username.text,
                                  password.text,
                                );
                                print(result);
                                if (result != null) {
                                  User user = User.fromMap(result);
                                  await Spreferences.setIsLogin(true);
                                  await Spreferences.setCurrentUserId(user.id!);
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Login successful. Hi, ${user.username}.')),
                                  );
                                  Navigator.of(context)
                                      .pushReplacementNamed('/');
                                } else {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('User not found.')),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      gapwr(w: 6),
                      TextButton(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: const Color.fromARGB(255, 219, 168, 126),
                          ),
                        ),
                        onPressed: () {
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
