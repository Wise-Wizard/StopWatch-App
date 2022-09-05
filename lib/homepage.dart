// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'timerButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StopWatchTimer timer = StopWatchTimer();
  final isHours = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3AB0FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB562),
        title: const Text(
          'StopWatch',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2016/10/18/00/48/stopwatch-1749080__340.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              height: 55,
            ),
            StreamBuilder<int>(
              stream: timer.rawTime,
              initialData: timer.rawTime.value,
              builder: ((context, snapshot) {
                final time = snapshot.data;
                final showTime =
                    StopWatchTimer.getDisplayTime(time!, hours: isHours);
                return Card(
                  color: Color(0xFFF9F2ED),
                  margin:
                      EdgeInsets.only(left: 45, right: 45, top: 45, bottom: 20),
                  child: Text(
                    showTime,
                    style: TextStyle(
                        fontSize: 60,
                        color: Color(0xFFF87474),
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
            Divider(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerFunctions(
                  timer: timer,
                  functionName: 'Start',
                  Click: () {
                    timer.onExecute.add(StopWatchExecute.start);
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                TimerFunctions(
                  timer: timer,
                  functionName: 'Stop',
                  Click: () {
                    timer.onExecute.add(StopWatchExecute.stop);
                  },
                ),
              ],
            ),
            Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerFunctions(
                  timer: timer,
                  functionName: 'Reset',
                  Click: () {
                    timer.onExecute.add(StopWatchExecute.reset);
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                TimerFunctions(
                  timer: timer,
                  functionName: 'Lap',
                  Click: () {
                    timer.onExecute.add(StopWatchExecute.lap);
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => LapInfo(timer: timer),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
              children: [Text('${index + 1}. ${data.displayTime}')],
            );
          }),
          itemCount: lapTime!.length,
        );
      },
    );
  }
}
