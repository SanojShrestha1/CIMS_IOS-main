//Performance.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PerformanceSlider extends StatefulWidget {
  const PerformanceSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<PerformanceSlider> {
  List<int> data = [];
  int _focusedIndex = -1;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      data.add(Random().nextInt(100) + 1);
    }
  }

  void _onItemFocus(int index) {
    print(index);
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildItemDetail() {
    if (_focusedIndex < 0) {
      return Container(
        height: 250,
        child: Text("Nothing selected"),
      );
    }

    if (data.length > _focusedIndex) {
      return Container(
        height: 250,
        child: Text("index $_focusedIndex: ${data[_focusedIndex]}"),
      );
    }

    return Container(
      height: 250,
      child: const Text("No Data"),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == data.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    //horizontal
    return Container(
      width: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.8,
                    colors: [
                      Color.fromARGB(255, 143, 21, 12),
                      Color.fromARGB(255, 112, 27, 22),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 130,
              width: 241,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 70,
                    width: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(255, 58, 17, 25),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(255, 58, 17, 25),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(255, 58, 17, 25),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(255, 58, 17, 25),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(255, 58, 17, 25),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  ///Override default dynamicItemSize calculation
  double customEquation(double distance) {
    // return 1-min(distance.abs()/500, 0.2);
    return 1 - (distance / 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ScrollSnapList(
              onItemFocus: _onItemFocus,
              itemSize: 260,
              itemBuilder: _buildListItem,
              itemCount: data.length,
              dynamicItemSize: true,
              // dynamicSizeEquation: customEquation, //optional
            ),
          ),
        ],
      ),
    );
  }
}