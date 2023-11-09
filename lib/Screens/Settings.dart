import 'package:cims/Screens/Profile.dart';
import 'package:cims/widgets/PrivacyPolicy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Functionality/Cache.dart';
import '../screens/Home.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsView(),
    );
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Example settings options
  bool notificationsEnabled = true;
  int notificationTime = 8;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromARGB(255, 152, 29, 29),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(ID: '')),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullScreenPhoto(imageUrl: 'assets/images/ccmt1.png'),
                ),
              );
            },
            child: Hero(
              tag: 'photoHero',
              child: Container(
                width: 350,
                height: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/ccmt1.png', fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                userProvider.profilePic,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            title: Text('Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => Profile())
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),
          if (notificationsEnabled)
          const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text('Notification Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: DropdownButton<int>(
                value: notificationTime,
                onChanged: (int? value) {
                  setState(() {
                    notificationTime = value ?? 8;
                  });
                },
                items: List.generate(24, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text('$index:00'),
                  );
                }),
              ),
            ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.public),
            title: Text('University Website', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              _launchURL('https://pu.edu.np/');
            },
          ),
          
          const SizedBox(height: 16),

          ListTile(
            leading: const Icon(Icons.link),
            title: Text('College Website', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              _launchURL('https://cosmoscollege.edu.np/');
            },
          ),
          
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text('Privacy Policy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(),
                ),
              );
            },
          ),
          // const SizedBox(height: 16),
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: Text('Log Out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          //   onTap: () {
          //     // Implement log out functionality
          // //   },
          // ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Image.asset('assets/images/facebook.png'),
                onPressed: () {
                  _launchURL('https://www.facebook.com/VisitCosmos');
                },
              ),
              IconButton(
                icon: Image.asset('assets/images/insta.jpeg'),
                onPressed: () {
                  _launchURL('https://www.instagram.com/cosmos.college.official/?hl=en');
                },
              ),
              IconButton(
                icon: Image.asset('assets/images/linkedin.png'),
                onPressed: () {
                  _launchURL('https://www.linkedin.com/company/cosmos-college-of-management-and-technology/?originalSubdomain=np');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FullScreenPhoto extends StatelessWidget {
  final String imageUrl;

  FullScreenPhoto({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.pop(context); // Go back when double-tapped
        },
        child: Center(
          child: Hero(
            tag: 'photoHero',
            child: Image.asset(imageUrl),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 