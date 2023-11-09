import 'package:cims/APIs/APIresult.dart';
import 'package:cims/Screens/Results.dart';
import 'package:cims/widgets/my_bargraph.dart';
import 'package:flutter/material.dart';

class breakdown extends StatefulWidget {
  final List result;
  final List subject;
  breakdown({
    required this.result,
    required this.subject,
    super.key,
  });

  @override
  breakdownState createState() => breakdownState();
}

class breakdownState extends State<breakdown> {
  @override
  Widget build(BuildContext context) {
    print("yeta okko:::::::::::::::::::${widget.result}");
    print("yeta okko:::::::::::::::::::${widget.subject}");

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:
          widget.result.length - 1, // Set the number of items in your list
      itemBuilder: (context, index) {
        // You can customize each item here based on the index
        // For example, you can provide different values for height, width, and sub:
        // Replace these with actual values or calculations based on your requirements
        int heightValue = Calculatepercentage(widget.result[index]);
        double widthValue = 60;
        String subValue = widget.result[index];

        return insider(
            heighti: heightValue,
            widthi: widthValue,
            sub: heightValue.toString());
      },
    );
  }
}

class insider extends StatefulWidget {
  final int heighti;
  final double widthi;
  final String sub;
  const insider(
      {required this.heighti,
      required this.widthi,
      required this.sub,
      super.key});

  @override
  // ignore: library_private_types_in_public_api
  insiderState createState() => insiderState();
}

class insiderState extends State<insider> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Color.fromARGB(230, 33, 31, 46),
                borderRadius: BorderRadius.circular(65.0),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: Text(
                  "${widget.sub}%",
                  style: TextStyle(
                      fontSize: 13, color: Color.fromARGB(255, 248, 100, 100)),
                ),
              ),
            ),
          ))
    ]);
  }
}

int Calculatepercentage(String grade) {
  if (grade == "A") {
    return 100;
  } else if (grade == "A-") {
    return 90;
  } else if (grade == "B+") {
    return 80;
  } else if (grade == "B") {
    return 75;
  } else if (grade == "B+") {
    return 70;
  } else if (grade == "B-") {
    return 65;
  } else if (grade == "C+") {
    return 60;
  } else if (grade == "C") {
    return 55;
  } else if (grade == "C-") {
    return 50;
  } else if (grade == "D") {
    return 45;
  } else {
    return 0;
  }
}