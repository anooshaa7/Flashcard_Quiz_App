import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Widget? image; // Use a Widget to allow for any type of image (AssetImage, NetworkImage, etc.)

  const RoundButton({
    super.key,
    required this.text,
    this.image, // Make the image optional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.greenAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) image!, // Display the image if provided
            const SizedBox(height: 8), // Add some spacing between the image and text
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
