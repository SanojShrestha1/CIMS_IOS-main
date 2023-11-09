import 'dart:io' show Platform;
import 'dart:ui';
import 'package:android_id/android_id.dart';
import 'ForgotPassword.dart';
import 'globals.dart' as globals;
import 'package:cims/widgets/custom_formfield.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'splashscreen.dart';
import 'package:cims/Model/variable.dart' as information;
import 'package:cims/screens/home.dart';
import 'package:http/http.dart' as http;

bool isAnimating = true;
dynamic arr = [];

//enum to declare 3 state of button
enum ButtonState { init, submitting, completed }

class ButtonStates extends StatefulWidget {
  const ButtonStates({Key? key}) : super(key: key);

  @override
  _ButtonStatesState createState() => _ButtonStatesState();
}

class _ButtonStatesState extends State<ButtonStates> {
  ButtonState state = ButtonState.init;
  GetDeviceId deviceIdWidget = GetDeviceId();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  bool obsecurepassword = true;
  String _encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

// Function to perform user login
  Future<int?> loginUser(String email, String password, String deviceId) async {
    String apiUrl =
        '${globals.ServerIP}login'; // Replace with your Node.js API URL
    try {
      // Create a JSON object with the user's email, password, and deviceId
      final data = {
        'Email_Id': email,
        'password': password,
        'Device_Id': deviceId,
      };
      // Send a POST request to the login route of the Node.js API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      print(data);
      // Parse the response JSON
      final responseData = json.decode(response.body);
      information.ID = responseData['id'].toString();
      print("😍😍😍 ${responseData['message']}");
      print("😍😍😍 ${responseData['id']}");

      if (responseData['message'] == 'Login successful') {
        return responseData['id'];
      } else if (responseData['message'] == 'Invalid') {
        return 2;
      }
    } catch (e) {
      return 0;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    //Future<String?> deviceId = deviceIdWidget.getDeviceIdAsString();
    //print('Device ID: ${deviceId ?? '-'}');
    // update the UI depending on below variable values
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover),
              ),
              child: ClipRect(
                // ClipRect will apply the blur effect only to its child
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5), // Adjust the sigma values for blur intensity
                  child: Container(
                    color: Colors.black.withOpacity(
                        0), // Adjust the opacity for the blur effect
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(130, 50, 0, 0),
                          child: Text(
                            "Welcome !",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(170, 50, 0, 50),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomFormField(
                          headingText: "Email",
                          hintText: "ex. 180328saman@comsoscollege.edu.np",
                          obsecureText: false,
                          suffixIcon: const SizedBox(),
                          controller: _emailController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          validator: (s) {
                            if (!s!.isValidEmail()) {
                              return "Enter valid email";
                            }
                            return null;
                          },
                          isEmpty: email.isEmpty,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomFormField(
                          headingText: "Password",
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          hintText: "At least 8 characters",
                          obsecureText: obsecurepassword,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                obsecurepassword = !obsecurepassword;
                              });
                            },
                          ),
                          controller: _passwordController,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                          isEmpty: password.isEmpty,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                            right: 20.0,
                          ),
                          child: InkWell(
                            onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(),
                            ),
                          );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 252, 247, 247).withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GetDeviceId(),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              onEnd: () => setState(() {
                                isAnimating = !isAnimating;
                              }),
                              width:
                                  state == ButtonState.init ? buttonWidth : 70,
                              height: 60,
                              child: isInit
                                  ? buildButton()
                                  : circularContainer(isDone),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(220, 100, 5, 0),
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/ccmt1.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 112, 27, 22)),
          onPressed: () async {
            var sharedPref = await SharedPreferences.getInstance();
            sharedPref.setBool(SplashScreen.KEYLOGIN, true);
            final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
            String? deviceId;
            if (Platform.isIOS) {
              final iosInfo = await deviceInfo.iosInfo;
              deviceId = iosInfo.identifierForVendor;
            }

            setState(() {
              state = ButtonState.submitting;
            });

            try {
              String encryptedPassword = _encryptPassword(password);
              String message =
                  email + "," + encryptedPassword + "," + '${deviceId}';
              int? receivedID = await loginUser(
                  email, encryptedPassword, deviceId.toString());

              if (receivedID! > 2) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text('ID verification complete with ' +
                          receivedID.toString()),
                    ),
                  ),
                );
                setState(() {
                  state = ButtonState.completed;
                });
                await Future.delayed(const Duration(seconds: 2));
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(ID: information.ID),
                  ),
                );
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 21, 6),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text("Invalid Credentials"),
                    ),
                  ),
                );
                await Future.delayed(const Duration(seconds: 2));
                setState(() {
                  state = ButtonState.init;
                });
              }
            } on Exception catch (e) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: Container(
                    padding: const EdgeInsets.all(16),
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 21, 6),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text("${e}"),
                  ),
                ),
              );

              await Future.delayed(const Duration(seconds: 2));
              setState(() {
                state = ButtonState.init;
              });
            }
          },
          child: const Text('LOGIN'),
        ),
      );

  Widget circularContainer(bool done) {
    final color = done ? Colors.green : Colors.black;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? const Icon(Icons.done, size: 50, color: Colors.white)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}

class GetDeviceId extends StatefulWidget {
  @override
  _GetDeviceIdState createState() => _GetDeviceIdState();
}

class _GetDeviceIdState extends State<GetDeviceId> {
  String? deviceId;

  @override
  void initState() {
    super.initState();
    getDeviceIdAsString();
  }

  Future<String?> getDeviceIdAsString() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
    return deviceId;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Container(
    //   alignment: Alignment.center,
    //   margin: const EdgeInsets.only(
    //     top: 20.0,
    //     bottom: 20.0,
    //   ),
    //   child: Text(
    //     'Device ID: ${deviceId ?? '-'}',
    //     style: const TextStyle(
    //       color: Color.fromARGB(255, 240, 238, 238),
    //       fontSize: 16,
    //       fontWeight: FontWeight.w500,
    //     ),
    //   ),
    // );
  }
}

extension EmailValidation on String {
  bool isValidEmail() {
    // Add your email validation logic here
    // For example, you can use a regular expression to validate the email address
    final emailRegex = RegExp(r'^[\w-\.]+@cosmoscollege.edu.np');
    return emailRegex.hasMatch(this);
  }
}