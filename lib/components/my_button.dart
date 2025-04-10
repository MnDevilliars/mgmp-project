import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../appcolors/app_colors.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String url;

  const MyButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          onPressed();
          context.push(url);
        },
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20.0, color: Colors.greenAccent),
        ),
      ),
    );
  }
}
