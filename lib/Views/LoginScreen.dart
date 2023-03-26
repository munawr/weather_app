// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:weather_app/Views/Test.dart';

// class PhoneAuthScreen extends StatefulWidget {
//   @override
//   PhoneAuthScreenState createState() => PhoneAuthScreenState();
// }

// class PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   final _phoneController = TextEditingController();
//   final _smsController = TextEditingController();

//   String _verificationId = "";

//   // Function to initiate phone authentication
//   Future<void> _initiatePhoneAuth(String phoneNumber) async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     await auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Auto verification by SMS code
//         await auth.signInWithCredential(credential);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: const Text("Verification successful")),
//         );
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         // Handle verification failed exception
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Verification failed: ${e.message}")),
//         );
//         print("Verification failed: ${e.message}");
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         // Save verificationId to be used to enter code later
//         _verificationId = verificationId;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Code sent to $phoneNumber")),
//         );
//         print("Code sent to $phoneNumber");
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Handle timeout exception
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: const Text("Auto retrieval timeout")),
//         );
//         print("Auto retrieval timeout");
//       },
//     );
//   }

//   // Function to sign in using SMS code
//   Future<void> _signInWithSMSCode() async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     // Create PhoneAuthCredential using SMS code and verification ID
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId, smsCode: _smsController.text);

//     // Sign in using the credential
//     await auth.signInWithCredential(credential);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: const Text("Sign in successful")),
//     );
//     print("Sign in successful");
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("OTP Verification"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(hintText: "Enter Phone Number"),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => _initiatePhoneAuth(_phoneController.text),
//               child: const Text("Send SMS Code"),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: _smsController,
//                 decoration: const InputDecoration(hintText: "Enter SMS Code"),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => _signInWithSMSCode(),
//               child: const Text("Sign In"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }