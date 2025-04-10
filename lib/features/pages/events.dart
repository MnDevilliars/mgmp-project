import 'package:flutter/material.dart';


class Events extends StatelessWidget {
  Events({super.key});

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Event content will come here'),
        ],
      ),
    );
  }
}