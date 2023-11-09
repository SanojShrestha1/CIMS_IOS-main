import 'dart:convert';
import 'package:cims/screens/globals.dart' as globals;
import 'package:http/http.dart' as http;

// Custom class to hold teacher, subject, and time
class AttendanceData {
  final int user_id;
  final String date;
  final String time;
  final String Name; // yesko name database ma ra yesma change garna parne cha
  final String profile_pic;

  AttendanceData(
      this.user_id, this.time, this.date, this.Name, this.profile_pic);
}

Future<List<AttendanceData>> fetchATData(user_id) async {
  var userId = user_id;
  final Map<String, String> data = {
    'user_id': userId,
  };
  final response = await http.post(
    Uri.parse('${globals.ServerIP}attendance'),
    headers: {'Content-Type': 'application/json'},
    // Set the Content-Type header
    body: jsonEncode(data), // Serialize the data to JSON
  );
  print(data);
  if (response.statusCode == 200) {
    String jsonString = response.body;
    List<dynamic> jsonArray = jsonDecode(jsonString);

    // Assuming your JSON response looks like this: [[{data1}, {data2}], [{data3}, {data4}], ...]
    List<AttendanceData> dataList = [];

    for (var data in jsonArray) {
      dataList.add(AttendanceData(
        data['user_id'],
        data['timestamp'],
        data['Date'],
        data['Name'],
        data['profile_pic'],
      ));
    }

    print('Fetched data length:👌 ${dataList.length}');
    return dataList;
  } else {
    print(
        'maaaaaaaaaaaaaalFailed to fetch data. Error code: ${response.statusCode}');
    throw Exception('Failed to fetch data');
  }
}

Future<void> pushAttendanceData({
  required String userId,
  required String userName,
  required String time,
  required String profilePic,
  required String date,
}) async {
  final String apiUrl = '${globals.ServerIP}attend';

  final Map<String, String> data = {
    'user_id': userId,
    'user_name': userName,
    'date': date,
    'time': time,
    'profile_pic': profilePic,
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json'
    }, // Set the Content-Type header
    body: jsonEncode(data), // Serialize the data to JSON
  );

  if (response.statusCode == 200) {
    print('Data pushed successfully');
  } else {
    print('Failed to push data. Error code: ${response.statusCode}');
  }
}

Future<void> DELETEAttendanceData({
  required String userId,
  required String userName,
  required String time,
  required String profilePic,
  required String date,
}) async {
  final String apiUrl = '${globals.ServerIP}attenddelete';

  final Map<String, String> data = {
    'user_id': userId,
    'user_name': userName,
    'date': date,
    'time': time,
    'profile_pic': profilePic,
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json'
    }, // Set the Content-Type header
    body: jsonEncode(data), // Serialize the data to JSON
  );

  if (response.statusCode == 200) {
    print('Data pushed successfully');
  } else {
    print('Failed to DELETE data. Error code: ${response.statusCode}');
  }
}