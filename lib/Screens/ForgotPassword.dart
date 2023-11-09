import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Color.fromARGB(255, 8, 8, 8),
      ),
      body: Center(
        child: PasswordChangeScreen(),
      ),
    );
  }
}

class PasswordChangeScreen extends StatefulWidget {
  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _resetCodeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _emailIsEmpty = false;
  bool _invalidEmail = false;
  bool _resetCodeIsEmpty = false;
  bool _newPasswordIsEmpty = false;

  bool _canRequestResetCode = true;

  Future<void> sendResetCode() async {
    final email = _emailController.text;

    if (email.isEmpty) {
      setState(() {
        _emailIsEmpty = true;
        _invalidEmail = false;
      });
    } else if (!_isValidEmail(email)) {
      setState(() {
        _emailIsEmpty = false;
        _invalidEmail = true;
      });
    } else {
      setState(() {
        _emailIsEmpty = false;
        _invalidEmail = false;
      });

      if (!_canRequestResetCode) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Code Request Blocked"),
              content: Text(
                "You can request a reset code only after 10 minutes.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }

      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.75:3000/user'), 
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'user_email': email, 
          }),
        );

        if (response.statusCode == 200) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Code Sent"),
                content: Text(
                  "A reset code has been sent to your email address.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );

          setState(() {
            _canRequestResetCode = false;
          });

          Future.delayed(Duration(minutes: 10), () {
            setState(() {
              _canRequestResetCode = true;
            });
          });
        } else if (response.statusCode == 404) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Email Not Found"),
                content: Text(
                  "The email you provided was not found in our system.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(
                  "An error occurred while sending the reset code. Please try again later.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  Future<void> changePassword() async {
    final email = _emailController.text;
    final resetCode = _resetCodeController.text;
    final newPassword = _newPasswordController.text;

    if (email.isEmpty || resetCode.isEmpty || newPassword.isEmpty) {
      setState(() {
        _emailIsEmpty = email.isEmpty;
        _resetCodeIsEmpty = resetCode.isEmpty;
        _newPasswordIsEmpty = newPassword.isEmpty;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.75:3000/user/change-password'), 
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_email': email,
          'reset_code': resetCode, 
          'new_password': newPassword, 
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Password Changed"),
              content: Text(
                "Your password has been changed successfully.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );

        await http.post(
          Uri.parse('http://192.168.1.75:3000/user/success-email'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'user_email': email, 
          }),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Password Change Failed"),
              content: Text(
                "Failed to change your password. Please check your email and reset code.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Enter your email address to receive a code for password reset",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Email',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorText: _emailIsEmpty
                    ? 'Please insert email first'
                    : _invalidEmail
                        ? 'Incorrect email format'
                        : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendResetCode,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 169, 21, 43),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text("Send Code"),
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _resetCodeController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Reset Code',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorText: _resetCodeIsEmpty ? 'Please insert reset code' : null,
              ),
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorText: _newPasswordIsEmpty ? 'Please insert new password' : null,
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: changePassword,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 169, 21, 43),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text("Change Password"),
            ),
            SizedBox(height: 18),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromARGB(255, 169, 21, 43),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}
