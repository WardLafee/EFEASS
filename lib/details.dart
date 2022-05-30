import 'package:efeass/network.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  bool? value1;
  bool? value2;
  bool? value3;
  Details({Key? key, this.value1, this.value2, this.value3}) : super(key: key);
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  var network = Network("", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task-Api'),
        ),
        body: FutureBuilder<List<Network>?>(
          future: network.getUrl(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Widget wid = const Text('data');

                      final item = snapshot.data![index];
                      if (widget.value1 == true) {
                        Column(
                          children: [
                            wid = Text('${item.name},${item.currency}'),
                          ],
                        );
                      } else if (widget.value2 == true) {
                        wid = TextButton(
                          onPressed: () async {
                            if (!await launch(item.flag ?? ''))
                              throw 'Could not launch ${item.flag}';
                          },
                          child: Text('${item.name}'),
                        );
                      } else if (widget.value3 == true) {
                        wid = Text('${item.name}');
                      }
                      return wid;
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
