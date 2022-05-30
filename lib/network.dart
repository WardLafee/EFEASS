import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  String? name;
  String? currency;
  String? flag;
  Network(this.currency, this.name, this.flag);

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

  Network.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        currency = json['currency'],
        flag = json['flag'];
}
