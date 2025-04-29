import 'package:flutter/material.dart';

class EduButton extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final VoidCallback onPressed;
  final Color bgColor; // Background color for the button
  final Color textColor; // Color for the text

  EduButton({
    required this.label,
    required this.onPressed,
    this.prefixIcon,
    this.bgColor = const Color(0xFF7B61FF), // Default background color matching gradient
    this.textColor = Colors.white, // White text for contrast on the button
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centers the content
      crossAxisAlignment: CrossAxisAlignment.center, // Aligns to the center
      children: [
        SizedBox(
          width: 60, // Fixed width for the circular button
          height: 60, // Fixed height for the circular button
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()), // Circular shape
              backgroundColor: MaterialStateProperty.all(bgColor), // Use passed bgColor
              padding: MaterialStateProperty.all(EdgeInsets.zero), // Remove padding
            ),
            child: Icon(
              prefixIcon,
              color: Colors.white,
              size: 30, // Adjusted icon size for balance
            ),
          ),
        ),
        SizedBox(height: 8), // Adds space between the button and the label
        Text(
          label,
          style: TextStyle(
            fontSize: 14, // Slightly smaller font size for better proportion
            color: Colors.black, // Customizable text color
          ),
        ),
      ],
    );
  }
}
