import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:subway_time_app/subway/subway_screen.dart';

class SubwayApi {
  Future<List<Subway>> getSubwayInfo(String query) async {
    Uri url = Uri.parse(
        'http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/$query');
    http.Response response = await http.get(url);
    String jsonString = response.body;
    Map<String, dynamic> json = jsonDecode(jsonString);
    if (json['realtimeArrivalList'] == null) {
      return List.empty();
    }
    List<dynamic> realtimeArrivalList = json['realtimeArrivalList'];
    return realtimeArrivalList.map((e) => Subway.fromJson(e)).toList();
  }
}
