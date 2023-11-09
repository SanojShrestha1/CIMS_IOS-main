import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../screens/Home.dart';

class Notices extends StatefulWidget {
  const Notices({Key? key}) : super(key: key);

  @override
  _NoticesState createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {
  List<Map<String, dynamic>> _noticesData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.75:3000/api/notices'));

      if (response.statusCode == 200) {
        setState(() {
          _noticesData = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notices'),
        backgroundColor: Color.fromRGBO(174, 9, 9, 0.918),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  HomeScreen(ID: '')),
            );
          },
        ),
      ),
      body: _noticesData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _noticesData.length,
              itemBuilder: (context, index) {
                final notice = _noticesData[index];
                final title = notice['title'] as String? ?? '';
                final body = notice['body'] as String? ?? '';
                final date = notice['date'] as String? ?? '';
                final time = notice['time'] as String? ?? '';

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 32, 31, 31)),
                      ),
                      subtitle: Text(
                        '$date $time',
                        style: TextStyle(color: Color.fromARGB(255, 76, 72, 72)),
                      ),
                      onTap: () {
                        _showNoticeDetails(title, body);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showNoticeDetails(String title, String body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(body),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
