import 'package:flutter/material.dart';
import 'package:subway_time_app/subway/subway_api.dart';
import 'package:subway_time_app/subway/subway_view_model.dart';

class SubwayScreen extends StatefulWidget {
  const SubwayScreen({Key? key}) : super(key: key);

  @override
  State<SubwayScreen> createState() => _SubwayScreenState();
}

class _SubwayScreenState extends State<SubwayScreen> {
  final _controller = TextEditingController();
  String _query = '';
final _subwayApi = SubwayApi();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지하철 알리미'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 2),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _query = _controller.text;
                  },
                  child: const Icon(Icons.search),
                ),
                hintText: '지하철 정류장을 입력하세요',
              ),
            ),
          ListView(
            children: [
              Text('')
            ],

          )],
        ),

      ),
    );
  }
}
