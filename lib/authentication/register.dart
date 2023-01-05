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
        color: const Color.fromARGB(200, 28, 16, 134),
        alignment: Alignment.center,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromARGB(255, 127, 207, 95), width: 5),
              borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
            ),
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// username
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 20),
                      child: TextFormField(
                          controller: username,
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
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.people),
                              labelText: "Username",
                              enabledBorder: myinputborder(),
                              focusedBorder: myfocusborder(),
                              hintText: 'Please enter username')),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10),
                      child: TextFormField(
                          controller: fName,
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
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.people),
                              labelText: "First Name",
                              enabledBorder: myinputborder(),
                              focusedBorder: myfocusborder(),
                              hintText: 'Please enter first name')),
                    ),

                    const SizedBox(height: 10.0),

                    // Formfield lName
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                          controller: lName,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }

                            if (value.trim().length < 4) {
                              return 'Name must be at least 4 characters in length';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.people),
                              labelText: "Last Name",
                              enabledBorder: myinputborder(),
                              focusedBorder: myfocusborder(),
                              hintText: 'Please enter last name')),
                    ),

                    const SizedBox(height: 10.0),

                    // Formfield password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                          controller: mobileHp,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }

                            if (value.trim().length < 9) {
                              return 'Phone number must be at least 9 characters in length';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: "Phone Number",
                              enabledBorder: myinputborder(),
                              focusedBorder: myfocusborder(),
                              hintText: 'Please enter Phone Number')),
                    ),

                    const SizedBox(height: 10.0),

                    // Password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                          controller: password,
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
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: "Password",
                              enabledBorder: myinputborder(),
                              focusedBorder: myfocusborder(),
                              hintText: 'Please enter password')),
                    ),

                    gaphr(),

                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade200),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        onPressed: () async {
                          // If the form field validated
                          if (_formKey.currentState!.validate()) {
                            // Pass the local variable to database value
                            User user = User(
                                fName: fName.text,
                                lName: lName.text,
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
                      height: 50,
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
                          TextButton(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: const Color.fromARGB(255, 113, 52, 209),
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

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 186, 176, 212),
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 185, 121, 204),
          width: 3,
        ));
  }
}
