import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/page_second.dart';

class PageFirst extends StatefulWidget {
  const PageFirst({super.key});

  @override
  State<PageFirst> createState() => _PageFirstState();
}

class _PageFirstState extends State<PageFirst> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _palindrome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/ic_photo.png', width: 150, height: 150),
                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      hintText: "Name",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: .5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: .5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: .5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _palindrome,
                    decoration: InputDecoration(
                      hintText: "Palindrome",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: .5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: .5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: .5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      String name = _name.text;
                      String palindrome = _palindrome.text;

                      if (name.isEmpty || palindrome.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please fill in all fields',
                          backgroundColor: Colors.red[900],
                          colorText: Colors.white,
                        );
                      } else {
                        if (isPalindrome(palindrome)) {
                          Get.defaultDialog(
                            title: 'Result',
                            middleText: 'is palindrome',
                            titleStyle: TextStyle(color: Colors.white),
                            middleTextStyle: TextStyle(color: Colors.white),
                            textConfirm: 'Close',
                            confirmTextColor: Colors.white,
                            backgroundColor: Colors.green[800],
                            onConfirm: () {
                              Get.back();
                            },
                          );
                        } else {
                          Get.defaultDialog(
                            title: 'Result',
                            middleText: 'not palindrome',
                            titleStyle: TextStyle(color: Colors.white),
                            middleTextStyle: TextStyle(color: Colors.white),
                            backgroundColor: Colors.red[900],
                            textConfirm: 'Close',
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back();
                            },
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2B637B),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'CHECK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_name.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please fill name fields',
                          backgroundColor: Colors.red[900],
                          colorText: Colors.white,
                        );
                        return;
                      }
                      Get.to(
                        () => PageSecond(),
                        transition: Transition.rightToLeft,
                      );
                      Get.to(
                        () => PageSecond(),
                        transition: Transition.rightToLeft,
                      );
                      GetStorage().write('name', _name.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2B637B),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isPalindrome(String text) {
    String setText = text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toLowerCase();
    return setText == setText.split('').reversed.join('');
  }
}
