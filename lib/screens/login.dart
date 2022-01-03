import 'package:demo/model/Profile.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudyDo'),
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            './assets/images/Logo.png',
                            scale: 10,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Email Validator'),
                              EmailValidator(errorText: 'Wrong Email pattern')
                            ]),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: 'Email',
                            ),
                            onChanged: (email) {
                              profile.email = email.trim();
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Password Required';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: 'Password',
                            ),
                            onChanged: (password) {
                              profile.password = password.trim();
                            },
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'ลืมรหัสผ่าน',
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                        msg: "${e.message!}",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                }
                              },
                              child: Text('เข้าสู่ระบบ')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ยังไม่มีบัญชีผู้ใช้',
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text(
                                    'สมัครใช้งาน',
                                    style: TextStyle(fontSize: 15),
                                  ))
                            ],
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
}
