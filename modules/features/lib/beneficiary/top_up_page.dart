import 'package:core/blocs/top_up/top_up_cubit.dart';
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
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final id = args['id'];
    final nickname = args['nickname'];
    final phoneNumber = args['phoneNumber'];
    final monthlyTopUp = args['monthlyTopUp'];

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
      body: BlocConsumer<TopUpCubit, TopUpState>(
        listener: (context, state) {
          if (state.status == TopUpStatus.topUpFailure &&  state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                    SizedBox(height: 24.h),
                    Text(
                      '$nickname',
                      style: TextStyle(
                          color: Palette.accentColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Phone: $phoneNumber',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Month TopUp: $monthlyTopUp',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'The maximum you can top up $nickname this month is AED ${context.read<TopUpCubit>().calculateMaxTopUpForBeneficiary(id)}',
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Topping up'),
              duration: Duration(milliseconds: 500),
            ),
          );

          context.read<TopUpCubit>().topUp(id, selectedAmount);

          //show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Topped up successfully!'),
              duration: Duration(milliseconds: 500),
            ),
          );

          //delay & pop
          await Future.delayed(const Duration(milliseconds: 500));
          Navigator.pop(context);
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
