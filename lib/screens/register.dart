import 'package:demo/model/Profile.dart';
import 'package:demo/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new account'),
      ),
      body: Center(
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  Profile profile = new Profile();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Username Required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              hintText: 'ชื่อผู้ใช้',
                            ),
                            onChanged: (username) {
                              profile.username = username.trim();
                            },
                            //controller: username,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Email Validator'),
                              EmailValidator(errorText: 'Wrong Email pattern')
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              hintText: 'Email',
                            ),
                            onChanged: (email) {
                              profile.email = email.trim();
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Password Required';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              hintText: 'รหัสผ่าน',
                            ),
                            onChanged: (password) {
                              profile.password = password.trim();
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'password Require';
                              }
                              if (value != profile.password) {
                                return 'Password Mismatch';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              hintText: 'ยืนยันรหัสผ่าน',
                            ),
                            onChanged: (cPassword) {
                              profile.cPassword = cPassword.trim();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                )),
                                onPressed: () async {
                                  registerFirebase();
                                },
                                child: Text('ลงทะเบียน')),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }
          return Container();
        });
  }

  Future<Null> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: profile.email, password: profile.password)
            .then((value) {
          formKey.currentState!.reset();
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: e.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      }
    });
  }
}
