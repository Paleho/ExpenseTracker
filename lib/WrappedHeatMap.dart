import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class WrappedHeatMap extends StatelessWidget {
  final DateTime endDate;
  final Color maxColor = Colors.green.shade700;
  final Color saturatedColor = Colors.red.shade900;
  Map<int, Color>? myColorSet;

  WrappedHeatMap({super.key, required this.endDate}) {
    myColorSet = <int, Color>{
      1: maxColor.withOpacity(0.1),
      2: maxColor.withOpacity(0.2),
      3: maxColor.withOpacity(0.3),
      4: maxColor.withOpacity(0.4),
      5: maxColor.withOpacity(0.5),
      6: maxColor.withOpacity(0.6),
      7: maxColor.withOpacity(0.7),
      8: maxColor.withOpacity(0.8),
      9: maxColor.withOpacity(0.9),
      10: maxColor.withOpacity(1),
      11: saturatedColor,
    };
  }

  @override
  Widget build(BuildContext context) {
    // Display 13 weeks
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day - 7 * 13);

    return Container(
      width: 389,
      child: HeatMap(
        datasets: {
          DateTime(2023, 5, 1): 1,
          DateTime(2023, 5, 2): 8,
          DateTime(2023, 5, 3): 8,
          DateTime(2023, 5, 4): 10,
          DateTime(2023, 4, 25): 2,
          DateTime(2023, 4, 26): 0,
          DateTime(2023, 4, 20): 5,
          DateTime(2023, 5, 6): 20,
          DateTime(2023, 3, 6): 100,
        },
        startDate: startDate,
        endDate: endDate,
        colorMode: ColorMode.color,
        showColorTip: false,
        scrollable: true,
        colorsets: myColorSet!,
      ),
    );
  }
}
