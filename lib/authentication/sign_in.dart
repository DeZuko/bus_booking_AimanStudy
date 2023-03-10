import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytest/authentication/shared_preferences.dart';
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
  // Declare form key instance
  final _formKey = GlobalKey<FormState>();

  // Declare controller instance for textformfield
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
                const SizedBox(
                  height: 50,
                ),

                // Display welcome title
                const Padding(
                  padding: EdgeInsets.only(top: 150, left: 62, right: 67),
                  child: Text(
                    'Welcome!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),

                // Display subtitle
                const Padding(
                  padding: EdgeInsets.only(left: 80, right: 70, bottom: 30),
                  child: Text(
                    'Please sign in to continue.',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color.fromARGB(255, 181, 177, 177),
                    ),
                  ),
                ),

                // Username Form Field
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.people),
                        labelText: "Username",
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                        hintText: 'Please enter username'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10.0),

                // Password Form Field
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: "Password",
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                        hintText: 'Please enter password'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                // Submit Button
                Container(
                  margin: const EdgeInsets.all(25),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 10)),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 19),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Check if the input username and password correct
                        // Based on user table
                        dynamic result = await DatabaseServices(db: db).login(
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
                          // Navigate to FirstPage()
                          Navigator.of(context).pushReplacementNamed('/');
                        } else {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Wrong username or password')),
                          );
                        }
                      }
                    },
                  ),
                ),

                // Register button
                SizedBox(
                  width: double.infinity,
                  height: 80,
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
                      TextButton(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: const Color.fromARGB(255, 131, 124, 233),
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

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 207, 199, 213),
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 115, 75, 154),
          width: 3,
        ));
  }
}
