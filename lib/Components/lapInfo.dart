import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class LapInfo extends StatelessWidget {
  final StopWatchTimer timer;
  LapInfo({required this.timer});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StopWatchRecord>>(
      stream: timer.records,
      initialData: timer.records.value,
      builder: (context, snapshot) {
        final lapTime = snapshot.data;
        return ListView.builder(
          itemBuilder: ((context, index) {
            final data = lapTime![index];
            return Column(
              children: [
                Text(
                  '${index + 1}. ${data.displayTime}',
                  style: TextStyle(color: Color(0xFFF9F2ED), fontSize: 45),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  height: 10,
                )
              ],
            );
          }),
          itemCount: lapTime!.length,
        );
      },
    );
  }
}
