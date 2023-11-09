import 'package:cims/APIs/APIresult.dart';
import 'package:cims/Functionality/notesmanager.dart';
import 'package:cims/Screens/ToggleButton.dart';
import 'package:flutter/material.dart';

class barGraph extends StatefulWidget {
  // final double h1;
  // final double w1;
  final List subject;
  final List result;
  barGraph({
    // required this.h1,
    // required this.w1,
    required this.subject,
    required this.result,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  barGraphState createState() => barGraphState();
}

class barGraphState extends State<barGraph> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:
          widget.result.length - 1, // Set the number of items in your list
      itemBuilder: (context, index) {
        //  can customized each item here based on the index
        // For example, you can provide different values for height, width, and sub:
        // Replace these with actual values or calculations based on your requirements
        print(index);
        double heightValue = calculateValueForH1(widget.result[index]);
        double widthValue = 60;
        String subValue = widget.result[index];
        String subname = widget.subject[index];

        return barBox(
            heighti: heightValue,
            widthi: widthValue,
            sub: subValue,
            name: subname);
      },
    );
  }
}

class barBox extends StatefulWidget {
  final double heighti;
  final double widthi;
  final String sub;
  final String name;

  const barBox(
      {required this.heighti,
      required this.widthi,
      required this.sub,
      required this.name,
      super.key});

  @override
  // ignore: library_private_types_in_public_api
  barBoxState createState() => barBoxState();
}

class barBoxState extends State<barBox> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text(
        widget.sub,
        style: TextStyle(
            color: Color.fromARGB(65, 255, 255, 225),
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
          // height: 140,
          // width: 80,
          height: widget.heighti,
          width: widget.widthi,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              tileMode: TileMode.decal,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 77, 12, 7),
                Color.fromARGB(255, 44, 11, 9),
              ],
            ),
          ),
        ),
      ),
      Text(
        widget.name,
        style: TextStyle(
            color: Color.fromARGB(155, 255, 255, 225),
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    ]);
  }
}

double calculateValueForH1(String grade) {
  // Implement your logic here to map grades to numerical values
  // Example logic: A=150, B=100, C=50, etc.
  if (grade == "A") {
    return 150;
  } else if (grade == "A-") {
    return 125;
  } else if (grade == "B+") {
    return 100;
  } else if (grade == "B") {
    return 85;
  } else if (grade == "B-") {
    return 60;
  } else if (grade == "C+") {
    return 45;
  } else if (grade == "C") {
    return 40;
  } else if (grade == "C-") {
    return 35;
  } else if (grade == "D+") {
    return 30;
  } else if (grade == "D") {
    return 20;
  } else {
    return 10;
  }
}