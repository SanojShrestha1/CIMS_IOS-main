import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Home.dart';
import 'globals.dart' as globals;

class Category {
  final String title;
  final Color color;
  final List<String> semesterLinks;

  Category({
    required this.title,
    required this.color,
    required this.semesterLinks,
  });
}

class CategoryBox extends StatelessWidget {
  final Category category;

  CategoryBox({required this.category});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchURL(category.semesterLinks[0]);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              //color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 48,
              //color: Colors.white,
            ),
            SizedBox(height: 12),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 18,
                //color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.semesterLinks.length <= 8
                    ? category.semesterLinks.length
                    : 8,
                itemBuilder: (context, semesterIndex) {
                  final semester = 'Semester ${semesterIndex + 1}';
                  final semesterLink = category.semesterLinks[semesterIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        _launchURL(semesterLink);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 112, 27, 22),
                        onPrimary: Colors.white,
                        backgroundColor: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        semester,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          //color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Notes extends StatelessWidget {
  final List<Category> categories = [
    Category(
      title: 'Computer',
      color: Color.fromARGB(255, 112, 27, 22),
      semesterLinks: [
        'https://drive.google.com/drive/folders/1Yv8jfhXTJCHiUhs7IxIZoJsd8ywDJEq4',
        'https://drive.google.com/drive/folders/1cqnq6gSD-4_G8MhWBYbTOqQxfn__IFRV',
        'https://drive.google.com/drive/folders/1ewHxnVN5RM3S0qkvInKoZyU0rk1lstiJ',
        'https://drive.google.com/drive/folders/1GHUF_Mgid4GGHydxYcpHuOhOHmvF9UkQ',
        'https://drive.google.com/drive/folders/1i2lNJm9_OPKMG8P0lAfwyXS002zEtSkG',
        'https://drive.google.com/drive/folders/1AmpYySDkDX1scv_PDnEdhSaTL2OVsD1F',
        'https://drive.google.com/drive/folders/1luT7JFUWkSl_WS4JH_3UxtpOZAEEiLXU',
        'https://drive.google.com/drive/folders/1FZB7yseOg2733r0tqFOSMXsjWc75FjLa',
      ],
    ),
    Category(
      title: 'Civil',
      color: Color.fromARGB(255, 112, 27, 22),
      semesterLinks: [
        'https://drive.google.com/drive/folders/1TeNIAfJRe1FKPdtIIS_EtYNFvFK3qAA8',
        'https://drive.google.com/drive/folders/1RVaOLvvwmTdZeHzDYtGkBfngmLdu_6N6',
        'https://drive.google.com/drive/folders/1uDhDDNoi5E6T637ivY-IdaSEDd0Tdex3',
        'https://drive.google.com/drive/folders/1V6Gc5U0up44aZ-Vrsn6MerVlYoDWE5ZG',
        'https://drive.google.com/drive/folders/1XxVD9aDgMIrNrp4TVveoZEKtQaQSXx1t',
        'https://drive.google.com/drive/folders/10SsdU22EHvcXe2R0E5uYqPHyq5BRgaHj',
        'https://drive.google.com/drive/folders/1orzhy92MowiUFwIz76mL-XUyhcNVTPaH',
        'https://drive.google.com/drive/folders/1MXteCJY_sruS7ABo5qSCBW5nb62226T4',
      ],
    ),
    Category(
      title: 'IT',
      color: Color.fromARGB(255, 112, 27, 22),
      semesterLinks: [
        'https://drive.google.com/drive/folders/1upIb-Q1Xn-xKJDpnwEKXTXPKFwsofgo2',
        'https://drive.google.com/drive/folders/1yewMy5ADeqCAHLzb3cX2k7tLVcWv0M_2',
        'https://drive.google.com/drive/folders/113aH9HMYFt07gTW3uRQHYEbWQnppZ7Cx',
        'https://drive.google.com/drive/folders/1Wp3W6KYC2LqmCx5G4CZ_0X_n3GXETbVU',
        'https://drive.google.com/drive/folders/1ImNvuH3lWx16ugFsl6E4VurDQaA5a_Sm',
        'https://drive.google.com/drive/folders/1prAfGfCT8aRw4wquhUeUi6I2yP5mSRhF',
        'https://drive.google.com/drive/folders/1nUyWG4qHPHupck1LS2tqsMOAdQGLQB0U',
        'https://drive.google.com/drive/folders/1L8hdB9UdFrvy9XucobI5v4up55IRFS8j',
      ],
    ),
    Category(
      title: 'Electronics',
      color: Color.fromARGB(255, 112, 27, 22),
      semesterLinks: [
        'https://drive.google.com/drive/folders/1Yv8jfhXTJCHiUhs7IxIZoJsd8ywDJEq4?usp=sharing',
        'https://drive.google.com/drive/folders/1cqnq6gSD-4_G8MhWBYbTOqQxfn__IFRV?usp=drive_link',
        'https://drive.google.com/drive/folders/1ewHxnVN5RM3S0qkvInKoZyU0rk1lstiJ?usp=drive_link',
        'https://drive.google.com/drive/folders/1GHUF_Mgid4GGHydxYcpHuOhOHmvF9UkQ?usp=drive_link',
        'https://drive.google.com/drive/folders/1i2lNJm9_OPKMG8P0lAfwyXS002zEtSkG?usp=drive_link',
        'https://drive.google.com/drive/folders/1AmpYySDkDX1scv_PDnEdhSaTL2OVsD1F?usp=drive_link',
        'https://drive.google.com/drive/folders/1luT7JFUWkSl_WS4JH_3UxtpOZAEEiLXU?usp=drive_link',
        'https://drive.google.com/drive/folders/1FZB7yseOg2733r0tqFOSMXsjWc75FjLa?usp=drive_link',
      ],
    ),
    Category(
      title: 'Architecture',
      color: Color.fromARGB(255, 112, 27, 22),
      semesterLinks: [
        'https://drive.google.com/drive/folders/1Yv8jfhXTJCHiUhs7IxIZoJsd8ywDJEq4?usp=sharing',
        'https://drive.google.com/drive/folders/1cqnq6gSD-4_G8MhWBYbTOqQxfn__IFRV?usp=drive_link',
        'https://drive.google.com/drive/folders/1ewHxnVN5RM3S0qkvInKoZyU0rk1lstiJ?usp=drive_link',
        'https://drive.google.com/drive/folders/1GHUF_Mgid4GGHydxYcpHuOhOHmvF9UkQ?usp=drive_link',
        'https://drive.google.com/drive/folders/1i2lNJm9_OPKMG8P0lAfwyXS002zEtSkG?usp=drive_link',
        'https://drive.google.com/drive/folders/1AmpYySDkDX1scv_PDnEdhSaTL2OVsD1F?usp=drive_link',
        'https://drive.google.com/drive/folders/1luT7JFUWkSl_WS4JH_3UxtpOZAEEiLXU?usp=drive_link',
        'https://drive.google.com/drive/folders/1FZB7yseOg2733r0tqFOSMXsjWc75FjLa?usp=drive_link',
      ],
    ),
    Category(
      title: 'BBA',
      color: Color.fromARGB(255, 112, 27, 22),
      semesterLinks: [
        'https://drive.google.com/drive/folders/1Yv8jfhXTJCHiUhs7IxIZoJsd8ywDJEq4?usp=sharing',
        'https://drive.google.com/drive/folders/1cqnq6gSD-4_G8MhWBYbTOqQxfn__IFRV?usp=drive_link',
        'https://drive.google.com/drive/folders/1ewHxnVN5RM3S0qkvInKoZyU0rk1lstiJ?usp=drive_link',
        'https://drive.google.com/drive/folders/1GHUF_Mgid4GGHydxYcpHuOhOHmvF9UkQ?usp=drive_link',
        'https://drive.google.com/drive/folders/1i2lNJm9_OPKMG8P0lAfwyXS002zEtSkG?usp=drive_link',
        'https://drive.google.com/drive/folders/1AmpYySDkDX1scv_PDnEdhSaTL2OVsD1F?usp=drive_link',
        'https://drive.google.com/drive/folders/1luT7JFUWkSl_WS4JH_3UxtpOZAEEiLXU?usp=drive_link',
        'https://drive.google.com/drive/folders/1FZB7yseOg2733r0tqFOSMXsjWc75FjLa?usp=drive_link',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Management',
      themeMode: ThemeMode.system,
      theme: globals.ThemeClass.lightTheme,
      darkTheme: globals.ThemeClass.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes for Bachelor',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          //backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          ID: '',
                        )),
              );
            },
          ),
        ),
        body: Container(
          //color: Colors.grey[200],
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryBox(category: categories[index]);
            },
          ),
        ),
      ),
    );
  }
}