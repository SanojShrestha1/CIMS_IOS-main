// import 'package:cims/Screens/Home.dart';
// import 'package:cims/widgets/impro_slider.dart';
// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(children: [
//         Text("data"),
//         Container(
//           height: 150,
//           width: 500,
//           color: Colors.amber,
//           child: MYimproSlider(focusedIndex: 2),
//         ),
//         IconButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => HomeScreen(ID: '180328')));
//           },
//           icon: Icon(
//             Icons.audiotrack,
//             color: Colors.green,
//             size: 30.0,
//           ),
//         ),
//       ]),
//     );
//   }
// }