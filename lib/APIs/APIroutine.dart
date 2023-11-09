import 'dart:convert';
import 'dart:io';
import 'package:cims/Screens/globals.dart';
import 'package:cims/screens/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RoutineData {
  final String teacher;
  final String subject;
  final String time;

  RoutineData(this.teacher, this.subject, this.time);
}

class EventData {
  final String organizer;
  final String topic;
  final String time;

  EventData(this.organizer, this.topic, this.time);
}

Future<List<RoutineData>> fetchData() async {
  final timeoutDuration =
      Duration(seconds: 10); // Adjust the timeout duration as needed

  try {
    final response = await http
        .get(Uri.parse('${globals.ServerIP}routine'))
        .timeout(timeoutDuration);

    if (response.statusCode == 200) {
      ServerConnection = true;
      String jsonString = response.body;
      saveJsonToInternalStorage("Routinedata.json", jsonString);
    } else {
      print('Failed to fetch data. Error code: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw e;
  }
  var stringlist = await readJsonFromInternalStorage("Routinedata.json");
  print(stringlist);
  List<dynamic> jsonArray = jsonDecode(stringlist!);
  List<RoutineData> dataList = jsonArray
      .map((data) => RoutineData(
            data['teacher'],
            data['subject'],
            data['time'],
          ))
      .toList();

  print('Fetched data length:👌 ${dataList.length}');
  return dataList;
}

Future<List<RoutineData>> fetchDataToday() async {
  final timeoutDuration =
      Duration(seconds: 5); // Adjust the timeout duration as needed
  //final url = Uri.parse('http://172.16.22.156:3000/api/routine');
  //final url = Uri.parse('http://192.168.101.2:3000/api/routine');
  // Get the current system time
  
  try {
    DateTime currentTime = DateTime.now();

    // Extract the current hour as an integer
    int currentHour = currentTime.hour;
    if (currentHour >= 17) {
      final response = await http
          .post(
            (Uri.parse('${globals.ServerIP}routine_tomorrow')),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'semester': '"BCE-18"'}),
          )
          .timeout(timeoutDuration);
      if (response.statusCode == 200) {
        ServerConnection = true;
        String jsonString = response.body;
        saveJsonToInternalStorage("DailyRoutinedata.json", jsonString);
      } else {
        print(
            'Failed to fetch data. Error code:....................File is being read....................................... ${response.statusCode}');
        throw Exception('Failed to fetch data');
      }
    } else {
      final response = await http
          .post(
            (Uri.parse('${globals.ServerIP}routine_today')),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'semester': '"BCE-18"'}),
          )
          .timeout(timeoutDuration);
      if (response.statusCode == 200) {
        ServerConnection = true;
        String jsonString = response.body;
        saveJsonToInternalStorage("RoutineDailydata.json", jsonString);
      } else {
        print(
            'Failed to fetch data. Error code:....................File is being read....................................... ${response.statusCode}');
        throw Exception('Failed to fetch data');
      }
    }
  } catch (e) {
    print("yeehi ho routiney ko error");
  }
  var stringlist = await readJsonFromInternalStorage("DailyRoutinedata.json");
  print(stringlist);
  List<dynamic> jsonArray = jsonDecode(stringlist!);
  List<RoutineData> dataList = jsonArray
      .map((data) => RoutineData(
            data['teacher'],
            data['subject'],
            data['time'],
          ))
      .toList();
  print('cSave VAko data length:👌 ${dataList}');

  return dataList;
}

Future<List<EventData>> fetchEData() async {
  //final url = Uri.parse('http://172.16.22.156:3000/api/routine');
  //final url = Uri.parse('http://192.168.101.2:3000/api/routine');
  try {
    final response = await http.get(Uri.parse('${globals.ServerIP}event'));
    if (response.statusCode == 200) {
      ServerConnection = true;
      String jsonString = response.body;
      saveJsonToInternalStorage("Eventdata.json", jsonString);
    } else {
      print('Failed to fetch data. Error code: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    print("Khoi k error aayo${e}");
  }
  var stringlist = await readJsonFromInternalStorage("Eventdata.json");
  print("yo chai save vako data:::::::::::::::::::::::::${stringlist}");
  List<dynamic> jsonArray = jsonDecode(stringlist!);
  List<EventData> dataList = jsonArray
      .map((data) => EventData(
            data['organizer'],
            data['topic'],
            data['time'],
          ))
      .toList();
  return dataList;
}

Future<void> saveJsonToInternalStorage(
    String fileName, String jsonString) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');

    if (!await file.exists()) {
      await file.create();
    }

    await file.writeAsString(jsonString);
    print("La save chai vayo");
  } catch (e) {
    print('Error saving JSON data: $e');
  }
}

Future<String?> readJsonFromInternalStorage(String fileName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');

    if (await file.exists()) {
      return await file.readAsString();
    } else {
      return null;
    }
  } catch (e) {
    print('Error reading JSON data: $e');
    return null;
  }
}