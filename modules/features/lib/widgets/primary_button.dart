import 'package:dependencies/dependencies.dart';
import 'package:features/widgets/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.fadeAccentColor,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
      ),
      child: isLoading
          ? SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2.5.w,
              ),
            )
          : Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.white)),
    );
  }
}
