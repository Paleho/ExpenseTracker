import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'WrappedHeatMap.dart';
import 'heatmap_example.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Expense Tracker App')),
          WrappedHeatMap(endDate: DateTime.now()),
        ],
      ),
      // body: HeatMapExample(),
    );
  }
}
