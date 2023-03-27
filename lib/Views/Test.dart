// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class HomeLogin extends StatefulWidget {
//   @override
//   State<HomeLogin> createState() => _HomeLoginState();
// }

// class _HomeLoginState extends State<HomeLogin> {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   final TextEditingController _smsController = TextEditingController();

//   String _verificationId = '';

//   Future<void> _verifyPhoneNumber() async {
//     try {
//       final PhoneVerificationCompleted verificationCompleted =
//           (PhoneAuthCredential credential) async {
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         
//       };

//       final PhoneVerificationFailed verificationFailed =
//           (FirebaseAuthException authException) {
//         
//       };

//       final PhoneCodeSent codeSent =
//           (String verificationId, [int? forceResendingToken]) {
//         _verificationId = verificationId;
//         // TODO: Show dialog to enter SMS code
//       };

//       final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//           (String verificationId) {
//         _verificationId = verificationId;
//       };

//       await FirebaseAuth.instance.verifyPhoneNumber(
//           phoneNumber: _phoneNumberController.text,
//           timeout: const Duration(seconds: 60),
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//     } catch (e) {
//       // TODO: Handle exceptions
//     }
//   }

//   Future<void> _signInWithPhoneNumber() async {
//     try {
//       final PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: _smsController.text,
//       );
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       // TODO: Handle signed in user
//     } catch (e) {
//       // TODO: Handle exceptions
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('OTP Verification'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: _phoneNumberController,
//                   decoration: const InputDecoration(
//                       labelText: 'Phone number (+x xxx-xxx-xxxx)'),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: _verifyPhoneNumber,
//                 child: const Text('Verify Phone Number'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: _smsController,
//                   decoration: const InputDecoration(labelText: 'SMS code'),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: _signInWithPhoneNumber,
//                 child: const Text('Sign In'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
