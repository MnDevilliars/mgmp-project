import 'package:flutter/material.dart';
import './/components/my_card_button.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyCardButton(label: "Events", url: '/events'),
        SizedBox(height: 10,),
        MyCardButton(label: "Managers", url: '/event-manager'),
        SizedBox(height: 10,),
        MyCardButton(label: "Artists", url: '/artists'),
      ],
    );
  }
}
