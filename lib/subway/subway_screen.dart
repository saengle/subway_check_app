import 'package:flutter/material.dart';
import 'package:subway_time_app/subway/subway_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class Subway {
  final String trainLineNm;
  final String statnNm;
  final String arvlMsg2;

  Subway(
      {required this.statnNm,
      required this.trainLineNm,
      required this.arvlMsg2});

  factory Subway.fromJson(Map<String, dynamic> json) {
    return Subway(
      statnNm: json['statnNm'] as String,
      trainLineNm: json['trainLineNm'] as String,
      arvlMsg2: json['arvlMsg2'] as String,
    );
  }
}

class SubwayScreen extends StatefulWidget {
  const SubwayScreen({Key? key}) : super(key: key);

  @override
  State<SubwayScreen> createState() => _SubwayScreenState();
}

class _SubwayScreenState extends State<SubwayScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final subwayViewModel = context.read<SubwayViewModel>();
      subwayViewModel.fetchData(query);
    });
  }

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final subwayViewModel = context.watch<SubwayViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('지하철 알리미'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  if (value.isNotEmpty) _onSearchChanged(_controller.text);
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      subwayViewModel.fetchData(_controller.text);
                    },
                    child: const Icon(Icons.search),
                  ),
                  hintText: '지하철 정류장을 입력하세요',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: subwayViewModel.dataList.map((Subway dataList) {
                    return Column(
                      children: [
                        Text(dataList.arvlMsg2, style: TextStyle(fontSize: 17),),
                        Text(dataList.trainLineNm, style: TextStyle(fontSize: 17),),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
