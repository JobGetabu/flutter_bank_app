import 'package:core/data/models/beneficiary.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/beneficiary/top_up_page.dart';
import 'package:features/widgets/colors.dart';
import 'package:features/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class BeneficiaryCard extends StatelessWidget {
  final Beneficiary beneficiary;
  final Size size;

  const BeneficiaryCard({
    super.key,
    required this.size,
    required this.beneficiary,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: size.width * 0.4,
      ),
      child: Card(
        color: Colors.white,
        elevation: 2.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                beneficiary.nickname,
                style: TextStyle(
                    color: Palette.accentColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2.h),
              Text(
                beneficiary.phoneNumber,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 4.h),
              PrimaryButton(
                text: 'Recharge now',
                isLoading: false,
                onPressed: () {
                  Navigator.pushNamed(context, TopUpPage.routeName, arguments: {
                    'id': beneficiary.id,
                    'nickname': beneficiary.nickname,
                    'phoneNumber': beneficiary.phoneNumber,
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
