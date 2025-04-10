import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../appcolors/app_colors.dart';

class MyCardButton extends StatelessWidget {
  final String label;
  final String url;

  const MyCardButton({Key? key, required this.label, required this.url})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.deepOrange,
        onTap: () {
          context.push(url);
        },
        child: Container(
          color: AppColors.secondaryButton,
          child: SizedBox(
            width: 390,
            height: 75,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.event_note_outlined,
                        color: AppColors.iconColor,
                        size: 30.0,
                      ),
                      SizedBox(width: 5,),
                      Text(
                        label,
                        style: TextStyle(
                          color: AppColors.boldText,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
