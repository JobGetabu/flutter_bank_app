import 'package:dependencies/dependencies.dart';
import 'package:features/beneficiary/add_page.dart';
import 'package:features/widgets/beneficiary_card.dart';
import 'package:features/widgets/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/logo.png",
            colorBlendMode: BlendMode.clear,
            height: 100.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'My Beneficiaries',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Add and send money instantly up to AED 3000. \nRemaining this month: AED 2500',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 36.h),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height * 0.17,
            ),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return BeneficiaryCard(size: size);
              },
            ),
          ),
          SizedBox(height: 58.h),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddBeneficiary.routeName);
        },
        label: Text(
          'Add Beneficiary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Palette.fadeAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
