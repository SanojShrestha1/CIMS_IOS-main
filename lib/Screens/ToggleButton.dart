import 'package:cims/Screens/ClassViewer.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}



class _ToggleButtonState extends State<ToggleButton> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: globals.width,
        height: globals.height,
        decoration: const BoxDecoration(
          color: const Color.fromARGB(255, 127, 24, 32),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(globals.xAlign, 0),
              duration: Duration(milliseconds: 300),
              child: Container(
                width: globals.width * 0.5,
                height: globals.height,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  globals.xAlign = globals.loginAlign;
                  globals.loginColor = globals.selectedColor;
                  globals.signInColor = globals.normalColor;
                  globals.Current = true;
                });
                
              },
              child: Align(
                alignment: Alignment(-1, 0),
                child: Container(
                  width: globals.width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Current',
                    style: TextStyle(
                      fontSize: 12,
                      color: globals.loginColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  globals.xAlign = globals.signInAlign;
                  globals.signInColor = globals.selectedColor;
                  globals.loginColor = globals.normalColor;
                  globals.Current = false;
                });
              },
              child: Align(
                alignment: Alignment(1, 0),
                child: Container(
                  width: globals.width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 12,
                      color: globals.signInColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}