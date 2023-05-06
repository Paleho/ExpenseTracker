import 'package:flutter/material.dart';

import 'WrappedHeatMap.dart';

class HeatMapCard extends StatefulWidget {
  const HeatMapCard({super.key});

  @override
  State<HeatMapCard> createState() => _HeatMapCardState();
}

class _HeatMapCardState extends State<HeatMapCard> {
  DateTime currentEndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WrappedHeatMap(endDate: currentEndDate),
          ),
          Positioned(
            left: 10,
            top: 2,
            child: IconButton(
              onPressed: () {
                setState(() {
                  currentEndDate =
                      moveTime(initialDate: currentEndDate, months: -3);
                });
              },
              splashRadius: 15,
              icon: const Icon(Icons.keyboard_arrow_left_rounded),
            ),
          ),
          Positioned(
            right: 10,
            top: 2,
            child: IconButton(
              onPressed: () {
                setState(() {
                  currentEndDate =
                      moveTime(initialDate: currentEndDate, months: 3);
                });
              },
              splashRadius: 15,
              icon: const Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

DateTime moveTime(
    {required DateTime initialDate,
    int years = 0,
    int months = 0,
    int days = 0}) {
  return DateTime(initialDate.year + years, initialDate.month + months,
      initialDate.day + days);
}
