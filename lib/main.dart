import 'package:flutter/material.dart';
import 'package:flutter_covid19_api/stats_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_covid19_api/covid_today.dart';
import 'package:flutter_covid19_api/stats_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow COVID-19 Today',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Nextflow COVID-19 Today'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<CovidToday> getData() async {
    var response = await http.get('https://covid19.th-stat.com/api/open/today');
    var result = covidTodayFromJson(response.body);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<CovidToday> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    StatList(
                      title: 'ผู้ติดเชื้อสะสม',
                      covidresult: result.confirmed,
                      backgroundColor: Color(0xff9B1605),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StatList(
                      title: 'หายแล้ว',
                      covidresult: result.recovered,
                      backgroundColor: Color(0xff26AB09),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StatList(
                      title: 'กำลังรักษาอยู่ในโรงพยาบาล',
                      covidresult: result.hospitalized,
                      backgroundColor: Color(0xff1B95DB),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StatList(
                      title: 'เสียชีวิต',
                      covidresult: result.deaths,
                      backgroundColor: Color(0xff000000),
                    ),
                  ],
                ),
              );
            }
            return LinearProgressIndicator();
          },
        ));
  }
}
