import 'package:core/blocs/top_up/top_up_cubit.dart';
import 'package:core/di/injector.dart';
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
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    late BuildContext ctx;

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
        listener: (context, state) async {
          if(state.status == TopUpStatus.success){
            //show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Beneficiary added successfully'),
                duration: const Duration(milliseconds: 500),

              ),
            );

            //delay & pop
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.pop(ctx);
          }

          if (state.status == TopUpStatus.formErrors) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          ctx = context;

          return SafeArea(
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
                        labelStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.sp),
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
                        labelStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.sp),
                        hintText: "Enter UAE phone number (e.g., 05x xxxxxxx)",
                        border: const OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      keyboardType: TextInputType.phone,
                      enableSuggestions: false,
                      validator: validateUAEPhoneNumber,
                      controller: _phoneController,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  async {
          if (_formKey.currentState!.validate()) {
            //loading
            //option to use better loaders
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Adding beneficiary...'),
                duration: const Duration(milliseconds: 500),
              ),
            );

            ctx.read<TopUpCubit>().addBeneficiary(
                _nicknameController.text, _phoneController.text);

          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please correct the form errors')),
            );
          }
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
