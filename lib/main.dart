import 'dart:async';
import 'dart:convert';

import 'package:efeass/details.dart';
import 'package:efeass/network.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Checkbox Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Network>?> getUrl() async {
    var url = Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/info?returns=currency,dialcode,flag');
    http.Response respone = await http.get(url);
    if (respone.statusCode == 200) {
      String data = respone.body;
      var dataList = jsonDecode(data);
      Iterable dataList1 = dataList['data'];
      List<Network> listCatgory = [];

      for (var item in dataList1) {
        listCatgory.add(Network.fromJson(item));
      }
      return listCatgory;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getUrl();
  }

  var details = Details();
  bool? valuefirst = false;
  bool? valuesecond = false;
  bool? valuethird = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Checkbox Example'),
            ),
            body: Container(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Select which fields would like to get it\'s data ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  CheckboxListTile(
                    secondary: const Icon(Icons.currency_exchange),
                    title: const Text("Currency"),
                    subtitle:
                        const Text('Get all countries and their Currencies'),
                    value: valuefirst,
                    onChanged: (bool? value) {
                      setState(() {
                        valuefirst = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    secondary: const Icon(Icons.flag),
                    title: const Text('Flag'),
                    subtitle: const Text('Get all countries and their Flags'),
                    value: valuesecond,
                    onChanged: (bool? value) {
                      setState(() {
                        valuesecond = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    secondary: const Icon(Icons.accessibility),
                    title: const Text('Name'),
                    subtitle: const Text('Get all countries'),
                    value: valuethird,
                    onChanged: (bool? value) {
                      setState(() {
                        valuethird = value;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                value1: valuefirst,
                                value2: valuesecond,
                                value3: valuethird,
                              ),
                            ));
                      },
                      child: const Text('Submit'))
                ],
              ),
            )));
  }
}
