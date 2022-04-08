import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Difference between NTP and DEVICE time'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String get _deviceTime {
    DateTime deviceTime = DateTime.now();
    String _formatted = DateFormat('dd-MM-yyyy HH:mm:ss').format(deviceTime);
    return _formatted;
  }

  Future<String> get _ntpTime async {
    DateTime _ntpTime = await NTP.now();
    String _dateFormatted = DateFormat('dd-MM-yyyy HH:mm:ss').format(_ntpTime);
    return _dateFormatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Difference between NTP and DEVICE time',
            ),
            SizedBox(
              height: 5,
            ),
            FutureBuilder(
              future: _ntpTime,
              builder: (context, value) {
                return Text(
                  'NTP time: - ${value.data}',
                );
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Device time: - $_deviceTime',
            ),
          ],
        ),
      ),
    );
  }
}
