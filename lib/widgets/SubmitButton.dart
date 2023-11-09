import 'dart:ui';

import 'package:cims/Functionality/Cache.dart';
import 'package:cims/Screens/PdfViewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatefulWidget {
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

var i = 0;
const double width = 80;
const double height = 30;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _SubmitButtonState extends State<SubmitButton> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  // Function to show the file upload popup
  void _showUploadPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: 180,
                  width: 310,
                  decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.difference,
                    borderRadius: BorderRadius.circular(30.0),
                    //backgroundBlendMode: BlendMode.colorBurn,
                    color: const Color.fromARGB(77, 97, 97, 97),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Text(
                          'Upload File',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Text(
                          'Select a file to upload',
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.fromLTRB(130, 80, 10, 0)),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              setState(() {
                                xAlign = loginAlign;
                                loginColor = selectedColor;
                                signInColor = normalColor;
                              }); // Close the dialog
                            },
                            child: Text('Cancel',
                                style: TextStyle(
                                  color: Colors.white24,
                                )),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform the upload logic here
                              Navigator.pop(dialogContext); // Close the dialog
                              setState(() {
                                xAlign = loginAlign;
                                loginColor = selectedColor;
                                signInColor = normalColor;
                              });
                            },
                            child: Text('Upload',
                                style: TextStyle(color: Colors.amber)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      if (i == 0) {
        userProvider.loadUserInfo();
        i = 1;
      } else {}
    } catch (e) {}
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: const Color.fromARGB(255, 127, 24, 32),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(xAlign, 0),
              duration: Duration(milliseconds: 300),
              child: Container(
                width: width * 0.5,
                height: height,
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
                  xAlign = loginAlign;
                  loginColor = selectedColor;
                  signInColor = normalColor;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewer(),
                    ));
              },
              child: Align(
                alignment: Alignment(-1, 0),
                child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: userProvider.userRole == 's'
                        ? Text(
                            'View',
                            style: TextStyle(
                              fontSize: 11,
                              color: loginColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'View',
                            style: TextStyle(
                              fontSize: 11,
                              color: loginColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = signInAlign;
                  signInColor = selectedColor;
                  loginColor = normalColor;
                });
                if (userProvider.userRole == 's') {
                  // Show the file upload popup
                  _showUploadPopup(context);
                } else {
                  // Handle other cases if needed
                }
              },
              child: Align(
                alignment: Alignment(1, 0),
                child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: userProvider.userRole == 's'
                        ? Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 10,
                              color: signInColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Check',
                            style: TextStyle(
                              fontSize: 11,
                              color: signInColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}