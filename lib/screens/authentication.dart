// import 'package:flutter/material.dart';

// class Authencation extends StatefulWidget {
//   const Authencation({Key? key}) : super(key: key);

//   @override
//   _AuthencationState createState() => _AuthencationState();
// }

// class _AuthencationState extends State<Authencation> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [logo, login],
//       ),
//     );
//   }
// }

// Widget logo = Image.asset(
//   './assets/images/Logo.png',
//   scale: 10,
// );
// Widget login = Container(
//   width: 350,
//   child: Column(
//     children: [
//       TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           hintText: 'Email',
//         ),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       TextFormField(
//         validator: (value) {
//           if (value!.trim().isEmpty) {
//             return 'Password Required';
//           }
//           return null;
//         },
//         style: TextStyle(
//           fontSize: 12.0,
//         ),
//         obscureText: true,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           hintText: 'Password',
//         ),
//       ),
//       Container(
//         alignment: Alignment.topRight,
//         child: TextButton(
//             onPressed: () {},
//             child: Text(
//               'ลืมรหัสผ่าน',
//               style: TextStyle(fontSize: 15),
//             )),
//       ),
//       ElevatedButton(
//           style: ButtonStyle(
//               shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30)))),
//           onPressed: () async {
//             if (formKey.currentState!.validate()) {
//               formKey.currentState!.save();
//               try {
//                 await FirebaseAuth.instance
//                     .signInWithEmailAndPassword(
//                         email: profile.email, password: profile.password)
//                     .then((value) {
//                   formKey.currentState!.reset();
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => Home()));
//                 });
//               } on FirebaseAuthException catch (e) {
//                 Fluttertoast.showToast(
//                     msg: "${e.message!}",
//                     toastLength: Toast.LENGTH_LONG,
//                     gravity: ToastGravity.BOTTOM);
//               }
//             }
//           },
//           child: Text('เข้าสู่ระบบ')),
//     ],
//   ),
// );
