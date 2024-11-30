// // Define a StatefulWidget to hold the dynamic data
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';

class MyCircularChart extends StatefulWidget {
  final double percentageTask;
  final int completedTask;
  final int totalTasks;

  const MyCircularChart({
    super.key,
    required this.percentageTask,
    required this.completedTask,
    required this.totalTasks,
  });


  @override
  State<MyCircularChart> createState() => _MyCircularChartState();
}

class _MyCircularChartState extends State<MyCircularChart> {
  // Use a GlobalKey to access the AnimatedCircularChart state
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
      key: _chartKey,
      size: const Size(160.0, 160.0),
      initialChartData: <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
              widget.percentageTask,
              Colors.blue[400],
              rankKey: 'completed',
            ),
            CircularSegmentEntry(
              100 - widget.percentageTask,
              Colors.blueGrey[600],
              rankKey: 'remaining',
            ),
          ],
          // rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: true,
      holeLabel: '${widget.completedTask}/${widget.totalTasks}',
      labelStyle: TextStyle(
        color: AppColor.white,
        fontWeight: FontWeight.bold,
        fontSize: Dimen.dimen_20.sp,
      ),
    );
  }
}

