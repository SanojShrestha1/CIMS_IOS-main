import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:cosmos/Slider/aa.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

//import '../Slider/sample.dart';

class SampleData {
  final String name;
  final String email;

  SampleData({required this.name, required this.email});

  factory SampleData.fromJson(Map<String, dynamic> json) {
    return SampleData(name: json['name'], email: json['email']);
  }
}

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  late Future<List<SampleData>> _futureData; // Declare the Future

  @override
  void initState() {
    super.initState();
    _futureData = fetchData(); // Initialize the Future in initState
  }

  Future<List<SampleData>> fetchData() async {
  const String apiUrl = 'http://192.168.101.3:3000/api/routine';

  final response = await http.get(Uri.parse(apiUrl));
  print(response);
  if (response.statusCode == 200) {
    String jsonString = response.body;
    List<dynamic> jsonArray = jsonDecode(jsonString);
    print(jsonArray);
    List<SampleData> dataList = [];

    for (var data in jsonArray) {
      dataList.add(SampleData(
        name: data['semester'],
        email: data['day'],
      ));
    }

    return dataList;
  } else {
    print('Failed to fetch data. Error code: ${response.statusCode}');
    throw Exception('Failed to fetch data');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: const Color.fromARGB(255, 16, 15, 31),
        body: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Container(
              //color: const Color.fromARGB(255, 22, 21, 37),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                // alignment: Alignment.topCenter,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.add),
                                  label: const Text('\tAdd Sample'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 22, 21, 37),
                                    // elevation: 6, // Set the elevation of the button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  onPressed: () {
                                    fetchData();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const Sample()));
                                  },
                                ))),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none),
                              hintText: 'Search for Sample',
                              hintStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.white,
                              fillColor: Colors.white38,
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: FutureBuilder<List<SampleData>>(
                      future:
                          _futureData, // Use the Future that was initialized
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No data available'));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data![index].name),
                                subtitle: Text(snapshot.data![index].email),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}