import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import '../screens/Home.dart';
import 'package:cims/Model/variable.dart' as information;

class Routine extends StatefulWidget {
  const Routine({Key? key}) : super(key: key);

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  List<Map<String, dynamic>> _routineData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      final response = await http.get(Uri.parse('${globals.ServerIP}routine'));

      if (response.statusCode == 200) {
        setState(() {
          _routineData =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(
        label: Text(
          'Day',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'Teacher',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'Subject',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
    ];
  }

  List<DataRow> _buildDayRows(List<Map<String, dynamic>> entries) {
    List<DataRow> dayRows = [];
    String currentDay = '';
    for (final routine in entries) {
      if (routine['day'] != currentDay) {
        currentDay = routine['day'];
        dayRows.add(DataRow(cells: [
          DataCell(Text(currentDay,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 143, 21, 12),
              ))),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
        ]));
      }
      dayRows.add(DataRow(cells: [
        DataCell(Text('')),
        DataCell(Text(
          routine['time'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            //color: Color.fromRGBO(166, 166, 166, 0.965),
          ),
        )), // Display full time format as it is in the dataset
        DataCell(
          Text(
            routine['teacher'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              //color: Color.fromRGBO(166, 166, 166, 0.965),
            ),
          ),
        ),
        DataCell(Text(
          routine['subject'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            //color: Color.fromRGBO(166, 166, 166, 0.965),
          ),
        )),
      ]));
    }
    return dayRows;
  }

  List<Widget> _buildRoutineTables() {
    if (_routineData.isEmpty) {
      return [Center(child: CircularProgressIndicator())];
    }

    final groupedData = groupDataBySemesterAndSortByDayAndTime(_routineData);

    return groupedData.keys.map((semester) {
      final entries = groupedData[semester]!;

      List<DataRow> dayRows = _buildDayRows(entries);

      return Card(
        elevation: 4,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Semester: $semester',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Color.fromRGBO(166, 166, 166, 0.965)
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Classroom: ${entries.first['classroom']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(98, 98, 98, 0.965),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: _buildDataColumns(),
                rows: dayRows,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Map<String, List<Map<String, dynamic>>>
      groupDataBySemesterAndSortByDayAndTime(List<Map<String, dynamic>> data) {
    final Map<String, List<Map<String, dynamic>>> groupedData = {};
    data.forEach((routine) {
      final semester = routine['semester'] as String;
      if (!groupedData.containsKey(semester)) {
        groupedData[semester] = [];
      }
      groupedData[semester]!.add(routine);
    });

    return groupedData;
  }

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
          title: const Text('Routine'),
          //backgroundColor:
          //const Color.fromARGB(255, 6, 6, 6), // Use a consistent color scheme
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(ID: information.ID)),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildRoutineTables(),
            ),
          ),
        ),
      ),
    );
  }
}