
import 'package:flutter/material.dart';
import 'package:subway_time_app/subway/subway_api.dart';

class SubwayViewModel extends ChangeNotifier {
  final subwayApi = SubwayApi();

  List<Subway> dataList = [];

  void fetchImages(String query) async {
    dataList = await subwayApi.getSubwayInfo(query);
    notifyListeners();
  }
}
