import 'package:core/data/models/top_up_option.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/widgets/colors.dart';
import 'package:features/widgets/top_up_card.dart';
import 'package:flutter/material.dart';

class TopUpPage extends StatefulWidget {
  static const routeName = 'TopUpPage';

  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  double selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Icon(
                Icons.close,
                size: 30.sp,
              ),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top up \nBeneficiary',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 36.h),
                Text(
                  'Amit Pahandit',
                  style: TextStyle(
                      color: Palette.accentColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  '+971526798238',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 4.h),
                Text(
                  'The maximum you can top up Amit Pahandit this month is AED 2500',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Selected Amount',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '$selectedAmount AED',
                  style: TextStyle(
                      color: Palette.accentColor,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 24.h),
                Wrap(
                  spacing: 8.0, // Adjust spacing between items
                  runSpacing: 8.0, // Adjust spacing between rows
                  children: TOP_UP_OPTIONS
                      .map((topUpItem) => TopUpCard(
                          amount: topUpItem.amount,
                          onPressed: (topUpItem) {
                            setState(() {
                              selectedAmount = topUpItem;
                            });
                          }))
                      .toList(),
                ),
                SizedBox(height: 58.h),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Navigator.pushNamed(context, AddBeneficiary.routeName);
        },
        label: Text(
          'Top Up $selectedAmount AED',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
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
