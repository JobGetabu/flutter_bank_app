import 'package:dependencies/dependencies.dart';
import 'package:features/widgets/colors.dart';
import 'package:flutter/material.dart';

class TopUpCard extends StatelessWidget {
  final double amount;
  final Function(double amount) onPressed;

  const TopUpCard({
    super.key,
    required this.amount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){ onPressed(amount); },
      child: Card(
        color: Colors.white,
        elevation: 2.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          side: BorderSide(
            color: Colors.grey.shade300, // Border color
            width: 2, // Border width
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 2.h),
              Text(
                '${amount.toInt()}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 4.h),
              Text(
                'AED',
                style: TextStyle(
                    color: Palette.accentColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
