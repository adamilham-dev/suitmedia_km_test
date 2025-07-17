import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PageThird extends StatefulWidget {
  const PageThird({super.key});

  @override
  State<PageThird> createState() => _PageThirdState();
}

class _PageThirdState extends State<PageThird> {
  List<dynamic> _data = [];
  int _page = 1;
  int _totalPages = 2;
  bool _isLoading = false;
  bool _isLastPage = false;
  final ScrollController _scrollController = ScrollController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchData(initial: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          !_isLastPage &&
          _data.isNotEmpty) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData({bool initial = false}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      if (initial) _error = null;
    });
    try {
      final currentPage = initial ? 1 : _page + 1;
      dio.Response response = await dio.Dio().get(
        "https://reqres.in/api/users",
        queryParameters: {"page": currentPage},
      );
      final List<dynamic> newData = response.data['data'];
      _totalPages = response.data['total_pages'];
      setState(() {
        if (initial) {
          _data = newData;
          _page = 1;
        } else {
          _data.addAll(newData);
          _page = currentPage;
        }
        _isLastPage = _page >= _totalPages;
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = "Failed to load users.";
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _isLastPage = false;
    });
    await _fetchData(initial: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildList() {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _refresh,
              child: Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (_data.isEmpty && !_isLoading) {
      return ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.center,
            child: Text(
              "No users found.",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _data.length + (_isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index < _data.length) {
          final user = _data[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user['avatar']),
            ),
            title: Text(
              '${user['first_name']} ${user['last_name']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user['email']),
            onTap: () {
              GetStorage().write(
                'selected',
                '${user['first_name']} ${user['last_name']}',
              );
              Get.back();
            },
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
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
        onRefresh: _refresh,
        child: _buildList(),
      ),
    );
  }
}
