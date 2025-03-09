import 'package:flutter/material.dart';
class ElevatedBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const ElevatedBtn({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: child,
     style: ElevatedButton.styleFrom(
       backgroundColor: Colors.greenAccent.shade200,
       foregroundColor: Colors.white
     ),
    );
  }
}
