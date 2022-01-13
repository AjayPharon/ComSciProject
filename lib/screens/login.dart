import 'package:demo/model/Profile.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  Profile profile = new Profile();

  @override
  Widget build(BuildContext context) {
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
                                  borderRadius: BorderRadius.circular(30)))),
                      onPressed: () async {},
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
}
