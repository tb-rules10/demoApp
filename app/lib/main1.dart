import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/results_page.dart';
import 'package:http/http.dart' as http;
import 'package:app/build_buttons.dart';
import 'bottomNavBar.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
        ),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: const MyHomePage(),
    );
  }
}

enum Emotion {
  happy,
  normal,
  sad,
}

enum Genre {
  hiphop,
  bollywood,
  romantic,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color kInactiveButton = Color(0xFF1D1E33);
  Color kActiveButton = Colors.orange;
  String label = "Hip Hop";
  Emotion? selectedEmotion;
  Genre? selectedGenre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client-Server Connection"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Text(
                'Emotion',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  EmotionButton("Happy", Emotion.happy),
                  EmotionButton("Normal", Emotion.normal),
                  EmotionButton("Sad", Emotion.sad),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              const Text(
                'Genre',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GenreButton("Hip Hop", Genre.hiphop),
                  GenreButton("Bollywood", Genre.bollywood),
                  GenreButton("Romantic", Genre.romantic),
                ],
              )
            ],
          ),
          SizedBox(
            width: 250.0,
            child: Divider(
              color: Colors.teal.shade100,
              thickness: 1,
            ),
          ),
          BuildButtons(
            color: Colors.green,
            hover: Colors.greenAccent,
            label: "Submit",
            onPressed: (selectedEmotion == null || selectedGenre == null) ? null : () {
                    setState(() {
                      postData().then((result) {
                        // print('In Builder');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultsPage(output: result,),
                          ),
                        );
                      });
                    });
                  },
          ),
          // FutureBuilder<String>(
          //   future: postData(),
          //   builder: (context, snapshot) {
          //       return BuildButtons(
          //         color: Colors.green,
          //         hover: Colors.greenAccent,
          //         label: "Submit",
          //         onPressed: (selectedEmotion==null || selectedGenre==null) ? null : () {
          //           setState(() {
          //             Future<String> output = postData();
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => ResultsPage(output: snapshot.data,),
          //               ),
          //             );
          //           });
          //         },
          //       );
          //     }
          // )
        ],
      ),
    );
  }


  Future<Map<dynamic, dynamic>> postData() async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/input');
      Map<String, String> data = {
        'name': "TB",
        'emotion': selectedEmotion.toString(),
        'genre': selectedGenre.toString(),
      };
      String body = jsonEncode(data);
      print(body);
      final response = await http.post(url, body: body).timeout(const Duration(seconds: 2));
      Map<dynamic, dynamic> temp = json.decode(response.body);
      return temp;
    } catch (e) {
      print("ERROR - $e");
      Map<dynamic, dynamic> temp = {"msg" : "Bad Request or Server might be down :("};
      return temp;
    }
  }

  BuildButtons GenreButton(String label, Genre genre) {
    return BuildButtons(
      color: (selectedGenre == genre) ? kActiveButton : kInactiveButton,
      label: label,
      onPressed: () {
        setState(() {
          selectedGenre = genre;
        });
      },
    );
  }

  BuildButtons EmotionButton(String label, Emotion emotion) {
    return BuildButtons(
      color: (selectedEmotion == emotion) ? kActiveButton : kInactiveButton,
      label: label,
      onPressed: () {
        setState(() {
          selectedEmotion = emotion;
        });
      },
    );
  }
}
