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
  int _page = 1;
  final int _perPage = 10;
  bool _isLoading = false;
  bool _isLastPage = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData(initial: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          !_isLastPage) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData({bool initial = false, bool refresh = false}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      if (refresh || initial) {
        _isLastPage = false;
        _page = 1;
      }
    });

    try {
      dio.Response response = await dio.Dio().get(
        "https://reqres.in/api/users",
        queryParameters: {
          "page": _page,
          "per_page": _perPage,
        },
      );
      List<dynamic> users = response.data['data'];
      int totalPages = response.data['total_pages'];

      setState(() {
        if (refresh || initial) {
          _data = users;
        } else {
          _data.addAll(users);
        }
        _isLastPage = _page >= totalPages || users.isEmpty;
        if (!_isLastPage) _page++;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    await _fetchData(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildEmptyState() {
    return ListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Third Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _data.isEmpty && !_isLoading
            ? _buildEmptyState()
            : ListView.builder(
                controller: _scrollController,
                itemCount: _data.length + (_isLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index < _data.length) {
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
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
      ),
    );
  }
}
