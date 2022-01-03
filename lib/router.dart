import 'package:demo/screens/login.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/register.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (BuildContext context) => Login(),
  '/home': (BuildContext context) => Home(),
  '/regis': (BuildContext context) => Register(),
};
