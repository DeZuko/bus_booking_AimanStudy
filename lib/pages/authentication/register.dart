// The page perform below activities:
// Take form input
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytest/widgets/constant_widget.dart';
import 'package:mytest/models/user.dart';
import 'package:mytest/database/database_service.dart';
import 'package:mytest/database/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Declare global key for form
  final _formKey = GlobalKey<FormState>();
  // Declare text controller for input
  final fName = TextEditingController();
  final lName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final mobileHp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Database db = Provider.of<DbProvider>(context).db;
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(201, 250, 181, 53),
        alignment: Alignment.center,
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// username
                    TextFormField(
                      controller: username,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }

                        if (value.trim().length < 4) {
                          return 'Username must be at least 4 characters in length';
                        }
                        // Return null if the entered username is valid
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: fName,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }

                        if (value.trim().length < 4) {
                          return 'Username must be at least 4 characters in length';
                        }
                        // Return null if the entered username is valid
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: lName,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }

                        if (value.trim().length < 4) {
                          return 'Username must be at least 4 characters in length';
                        }
                        // Return null if the entered username is valid
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: mobileHp,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }

                        if (value.trim().length < 9) {
                          return 'phone number must be at least 9 characters in length';
                        }
                        // Return null if the entered username is valid
                        return null;
                      },
                    ),
                    // Password
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }

                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        // Return null if the entered password is valid
                        return null;
                      },
                    ),

                    gaphr(),

                    Container(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        child: const Text('Register'),
                        onPressed: () async {
                          // If the form field validated
                          if (_formKey.currentState!.validate()) {
                            // Pass the local variable to database value
                            User user = User(
                                fName: fName.text,
                                lName: fName.text,
                                password: password.text,
                                mobileHp: mobileHp.text,
                                username: username.text);

                            // Compare the login input with register table
                            dynamic result =
                                await DatabaseServices(db: db).register(user);
                            if (result == null) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Username already exist.')),
                              );
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Successfully register.')),
                              );
                              widget.toggleView();
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
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
                              "Sign in",
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
        ),
      ),
    );
  }
}
