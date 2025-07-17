import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/page_second.dart';

class PageThird extends StatefulWidget {
  const PageThird({super.key});

  @override
  _PageThirdState createState() => _PageThirdState();
}

class _PageThirdState extends State<PageThird> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      dio.Response response = await dio.Dio().get(
        "https://reqres.in/api/users",
      );
      _data = response.data['data'];
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Third Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_data[index]['avatar']),
            ),
            title: Text(
              '${_data[index]['first_name']} ${_data[index]['last_name']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_data[index]['email']),
            onTap: () {
              GetStorage().write(
                'selected',
                '${_data[index]['first_name']} ${_data[index]['last_name']}',
              );
              Get.to(() => PageSecond());
            },
          );
        },
      ),
    );
  }
}
