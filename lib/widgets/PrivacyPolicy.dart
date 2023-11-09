import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Color.fromARGB(255, 190, 43, 43),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Privacy Policy for CosX App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Effective Date: 2023',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Introduction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'Welcome to the Cosmos College of Management and Technology App provided by Cosmos IT Solution PVT.LTD.("we," "us," or "our"). This Privacy Policy is designed to help you understand how we collect, use, disclose, and safeguard your personal information. By downloading, installing, or using the App, you agree to the practices described in this Privacy Policy. If you do not agree to this Privacy Policy, please do not use the App.',
            ),
             SizedBox(height: 16.0),
            Text(
              '2. Information We Collect',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'Personal Information:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text(
                '-When you register for an account, we may collect personal information such as your name, email address, contact number, and other relevant details.'
                ),
                Text(
                '-In the course of using our system, you may provide additional information, including but not limited to academic records, attendance details, and other educational data.'
                ),
                Text(
              'Usage Data:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text(
                '-We may collect information about how you access and use our management system. This includes device information, IP addresses, browser types, and pages visited.'
                ),
                SizedBox(height: 16.0),
            Text(
              '3. How We Use Your Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'We use the collected information for various purposes, including but not limited to:',
              ),
              SizedBox(height: 10.0),
              Text(
                '-Providing and maintaining our college management system.'
                ),
                Text(
                '-Managing student records, attendance, and academic performance.'
                ),
                Text(
                '-Sending important announcements and notifications related to academic activities.'
                ),
                Text(
                '-Improving and customizing our services.'
                ),
                Text(
                '-Analyzing usage patterns to enhance the user experience.'
                ),

              SizedBox(height: 16.0),
                Text(
              '4. Data Security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              "-We prioritize the security of your personal information. While we strive to use commercially acceptable means to protect your data, we cannot guarantee absolute security. It's important to keep your account credentials confidential and notify us of any unauthorized access."
              ),

              SizedBox(height: 16.0),
                Text(
              '5. Disclosure of Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              "We do not sell, trade, or rent your personal information to third parties. However, we may disclose your information in the following circumstances:"
              ),
              SizedBox(height: 10.0),
              Text(
                '-With your consent.'
                ),
                Text(
                '-To comply with legal obligations.'
                ),
                Text(
                '-To protect and defend our rights and property.'
                ),

                SizedBox(height: 16.0),
                Text(
              '6. Your Choices',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              "You have the right to:"
              ),
              SizedBox(height: 10.0),
              Text(
                '-Request admin to update, or delete your personal information.'
                ),


                SizedBox(height: 16.0),
                Text(
              '7. Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
              Text(
                'We may update our Privacy Policy from time to time. The most current version will be posted on this page with the effective date.'
                ),
                

                SizedBox(height: 16.0),
                Text(
              '8. Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
              Text(
                'If you have any questions or concerns about our Privacy Policy, please contact us at :'
                ),
                SizedBox(height: 3.0),
              Text(
                'noreply@cosmoscollege.edu.np',
                style: TextStyle(
                fontWeight: FontWeight.bold,
              ),

                ),



          ],
        ),
      ),
    );
  }
}

