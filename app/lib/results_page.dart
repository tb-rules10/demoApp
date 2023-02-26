import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({super.key, required this.output});
  Map<dynamic, dynamic> output;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Your Playlist'),
      ),
      body: Center(
        child: Text(
          output["response"] != null ? output["response"] : output["response"],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
