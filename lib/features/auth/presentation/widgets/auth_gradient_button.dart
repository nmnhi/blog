import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  const AuthGradientButton(
      {super.key, required this.label, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            AppPalette.gradient1,
            AppPalette.gradient2,
            // AppPalette.gradient3
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius: BorderRadius.circular(8)),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 50),
            backgroundColor: AppPalette.transparentColor,
            foregroundColor: AppPalette.whiteColor,
            shadowColor: AppPalette.transparentColor),
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
