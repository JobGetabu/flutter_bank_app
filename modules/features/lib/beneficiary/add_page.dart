import 'package:core/utils/validators.dart';
import 'package:dependencies/dependencies.dart';
import 'package:features/widgets/colors.dart';
import 'package:flutter/material.dart';

class AddBeneficiary extends StatefulWidget {
  static const routeName = 'AddBeneficiary';

  const AddBeneficiary({super.key});

  @override
  State<AddBeneficiary> createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _PhoneController = TextEditingController();

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Beneficiary',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Nickname',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.h),
                FormBuilderTextField(
                  name: 'Nickname',
                  decoration: InputDecoration(
                    labelText: "Nickname",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    border: const OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  enableSuggestions: false,
                  validator: validateNickname,
                  controller: _nicknameController,
                ),
                SizedBox(height: 24.h),
                Text(
                  'UAE Phone Number',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.h),
                FormBuilderTextField(
                  name: 'Phone Number',
                  decoration: InputDecoration(
                    //labelText: "05xxxxxxxx",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    hintText: "Enter UAE phone number (e.g., 05x xxxxxxx)",
                    border: const OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  keyboardType: TextInputType.phone,
                  enableSuggestions: false,
                  validator: validateUAEPhoneNumber,
                  controller: _PhoneController,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        label: Text(
          'Add beneficiary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
        ),
        icon: const Icon(
          Icons.add_circle_outline,
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
