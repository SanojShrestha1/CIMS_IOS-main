// import 'package:new_cosx/screens/globals.dart';
// import 'package:flutter/material.dart';
// // Import the firebase_core plugin
// import 'package:firebase_core/firebase_core.dart';
// //Import firestore database
// import 'package:new_cosx/Model/variable.dart' as information;
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// String formattedDep = "3";

// int year = 4;
// int sem = 7;
// dynamic Class_location;
// List<String> semIDs = [];

// List<String> info = [];
// dynamic Name;
// dynamic profile_pic;
// dynamic ID;
// dynamic data;
// void main() async {
//   //Initializing Database when starting the application.
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
// }

// class GetUserName extends StatelessWidget {
//   final String documentId;

//   GetUserName(this.documentId);

//   @override
//   Widget build(BuildContext context) {
//     var now = new DateTime.now();
//     var formatter = new DateFormat('yyyy-MM-dd');

//     if (information.Email[0] != "1") {
//       year = 4;
//       sem = 7;
//     } else {
//       formattedDep = information.ID.substring(2, 4);
//       String formattedSem = information.ID.substring(0, 2);
//       year = (22 - (int.parse(formattedSem)));
//       sem = ((year * 2) - 1).floor();
//     }

//     String Class_location =
//         "/Attendence/" + formatter.format(now) + "/" + formattedDep;

//     FirebaseFirestore.instance.collection(Class_location).get().then(
//           (snapshot) => snapshot.docs.forEach(
//             (document) {
//               Map<String, dynamic> data = document.data();
//               String val = data['SUB'];
//               semIDs.add(val);
//               print("object");
//               print(semIDs);
//             },
//           ),
//         );
//     try {
//       //Class_location = Class_location + "/" + sem.toString() + "/" + semIDs[0];
//       Class_location = Class_location + "/" + "7" + "/" + "ELX 400";
//     } catch (e) {}
//     CollectionReference student = FirebaseFirestore.instance
//         .collection('/Attendence/2022-09-21/03/7/ELX 800');

//     return FutureBuilder<DocumentSnapshot>(
//       //Fetching data from the documentId specified of the student
//       future: student.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         //Error Handling conditions
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document no");
//         }
//         //Data is output to the user
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           data = data;
//           Timestamp timestamp = data['Joined At'];
//           dynamic value = (timeago.format(timestamp.toDate())).toString();
//           print(data);
//           return Text("${data['UserName']}" +
//                   '            ' +
//                   value +
//                   '           ' +
//                   documentId

//               //" : ${data["profile_pic"]}"
//               );
//         }

//         return CircularProgressIndicator(
//           backgroundColor: Colors.black,
//           color: Colors.black,
//         );
//       },
//     );
//   }
// }

// class GetSubjectName extends StatelessWidget {
//   final String documentId;

//   GetSubjectName(this.documentId);
//   String GetSubject(documentId) {
//     // TODO: implement GetSubject
//     throw UnimplementedError();
//   }

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference Subject =
//         FirebaseFirestore.instance.collection('Course');

//     return FutureBuilder<DocumentSnapshot>(
//       //Fetching data from the documentId specified of the student
//       future: Subject.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         //Error Handling conditions
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         //Data is output to the user
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           data = data;

//           return Text("${data['Name']}"
//                   "                                                         "
//                   " Credit: ${data["Credit"]}"
//                   "                                                 " +
//               information.Year);
//         }
//         return CircularProgressIndicator(
//           backgroundColor: Colors.black,
//           color: Colors.black,
//         );
//       },
//     );
//   }
// }
