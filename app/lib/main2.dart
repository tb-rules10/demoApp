import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/results_page.dart';
import 'package:http/http.dart' as http;

class DemoApp2 extends StatefulWidget {
  const DemoApp2({Key? key}) : super(key: key);

  @override
  State<DemoApp2> createState() => _DemoApp2State();
}

class _DemoApp2State extends State<DemoApp2> {
  TextEditingController myController = TextEditingController();
  bool isLoading = false;
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connecting ML Model"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 300,
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 5,
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.green,

              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                  postData(myController.text).then((result) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsPage(
                          output: result,
                        ),
                      ),
                    );
                  });
                });
                await Future.delayed(const Duration(seconds: 5));
                setState(() {
                  isLoading = false;
                });
              },
              child: (isLoading)
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,
                      ))
                  : const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Map<dynamic, dynamic>> postData(String textField) async {
  try {
    final url = Uri.parse('http://10.0.2.2:5000/api/predict');
    Map<String, String> data = {'text': textField};
    String body = jsonEncode(data);
    // Use `data` in request body if using Node.js server as backend
    // Use `body` in request body if using FastAPI server as backend
    final response = await http.post(url, body: body).timeout(const Duration(seconds: 5));
    Map<dynamic, dynamic> temp = await json.decode(response.body);
    return temp;
  } catch (e) {
    print("ERROR - $e");
    Map<dynamic, dynamic> temp = {
      "response": "Bad Request or Server might be down :("
    };
    return temp;
  }
}
