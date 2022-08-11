import 'package:http/http.dart' as http;
import 'dart:convert';


class Subway {
  final String trainLineNm;
  final String statnNm;
  final String arvlMsg2;

  Subway({required this.statnNm, required this.trainLineNm, required this.arvlMsg2});

  factory Subway.fromJson(Map<String, dynamic> json) {
    return Subway(
      statnNm: json['statnNm'] as String,
      trainLineNm: json['trainLineNm'] as String,
      arvlMsg2: json['arvlMsg2'] as String,
    );
  }
}

class SubwayApi {
  Future<List<Subway>> getSubwayInfo(String query) async {
    Uri url = Uri.parse(
        'http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/$query');
    http.Response response = await http.get(url);
    String jsonString = response.body;
    Map<String, dynamic> json = jsonDecode(jsonString);
    List<dynamic> realtimeArrivalList = json['realtimeArrivalList'];
    return realtimeArrivalList.map((e) => Subway.fromJson(e)).toList();
  }
}

