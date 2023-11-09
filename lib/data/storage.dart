// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart';

// Future<String> fetchJsonData() async {
//   // Create a http client.
//   final httpClient = HttpClient();

//   // Create a request.
//   final request = await httpClient.get('https://example.com/data.json');

//   // Get the response.
//   final response = await request.timeout(Duration(seconds: 10));

//   // Return the response body.
//   return response.body;
// }


// // Function to save JSON data
// void saveJsonData(String jsoncData, String fileName) {
//   // Create a file.
//   final file = File(fileName);

//   // Write the JSON data to the file.
//   file.writeAsStringSync(jsonData);
// }
// // Fetch the JSON data.
// final String jsonData = await fetchJsonData();

// // Save the JSON data.
// saveJsonData(jsonData, 'data.json');