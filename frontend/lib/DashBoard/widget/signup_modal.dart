import 'package:charles_warburton/DashBoard/models/signup_model.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../MarketPlace/widget/button.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../requests/dashboard_requests.dart';

typedef VoidValue = void Function();

class SignUpButton extends StatefulWidget {
  VoidValue callBackSignUp;
  SignUpButton({Key? key,
    required this.callBackSignUp,
  }) : super(key: key);

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  late SignUpModel? signUpModel;
  Future<void> signUpDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: AppColors.fontDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
          ),
          backgroundColor: AppColors.secondaryBackGroundDark,
          title: Container(
            padding: EdgeInsets.only(top: Dimensions.paddingTop),
            alignment: Alignment.center,
            child:  const TextNotificationHeading(text: "Sign Up",),
          ),
          content: SingleChildScrollView(
            child:  Container(
              width: AppConstants.maxWidth*0.75,
              margin: Dimensions.edgeInsetsAll,
              padding: Dimensions.edgeInsetsVertical,
              child: Form(
                  key: _formKey,
                  child:  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(
                                color: AppColors.fontDark,
                              ),
                              controller: firstNameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColors.good,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.account_circle_rounded,
                                  color: AppColors.fontDark,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                labelText: 'First Name',
                                labelStyle: const TextStyle(
                                  color: AppColors.fontDark,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusColor: AppColors.fontDark,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.paddingLeft/2,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(
                                color: AppColors.fontDark,
                              ),
                                controller: lastNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                cursorColor: AppColors.good,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                      borderSide: const BorderSide(color: AppColors.fontDark)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                      borderSide: const BorderSide(color: AppColors.fontDark)
                                  ),
                                  labelText: 'Last Name',
                                  labelStyle: const TextStyle(
                                    color: AppColors.fontDark,
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  focusColor: AppColors.fontDark,
                                ),
                              ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.paddingTop/2,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: AppColors.fontDark,
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: AppColors.good,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.alternate_email_rounded,
                            color: AppColors.fontDark,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                              borderSide: const BorderSide(color: AppColors.fontDark)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                              borderSide: const BorderSide(color: AppColors.fontDark)
                          ),
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                            color: AppColors.fontDark,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusColor: AppColors.fontDark,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.paddingTop/2,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: AppColors.fontDark,
                        ),
                        controller: password1Controller,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        cursorColor: AppColors.good,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.password_rounded,
                            color: AppColors.fontDark,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                              borderSide: const BorderSide(color: AppColors.fontDark)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                              borderSide: const BorderSide(color: AppColors.fontDark)
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: AppColors.fontDark,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusColor: AppColors.fontDark,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.paddingTop/2,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: AppColors.fontDark,
                        ),
                        controller: password2Controller,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        cursorColor: AppColors.good,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.password_rounded,
                            color: AppColors.fontDark,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                              borderSide: const BorderSide(color: AppColors.fontDark)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                              borderSide: const BorderSide(color: AppColors.fontDark)
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                            color: AppColors.fontDark,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusColor: AppColors.fontDark,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.paddingTop
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ButtonMarketPlace(
                                label: "Cancel",
                                icon: Icons.cancel_rounded,
                                radius: Dimensions.radius20,
                                color: AppColors.highLight,
                                onPressed: (() {
                                  Navigator.pop(context);
                                }),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.paddingLeft/4,
                            ),
                            Expanded(
                              child: ButtonMarketPlace(
                                label: "Sign up",
                                icon: Icons.check_circle_rounded,
                                radius: Dimensions.radius20,
                                color: AppColors.good,
                                onPressed: (() async {
                                  await GetSignUp(
                                    callBackSignUp: (signUpModel) {
                                      widget.callBackSignUp();
                                      Navigator.pop(context);
                                    },
                                    callBackError: (statusCode) {
                                      print("Error: $statusCode");
                                    },
                                    email: emailController.text,
                                    fName: firstNameController.text,
                                    lName: lastNameController.text,
                                    password: password1Controller.text,
                                    matchPassword: password2Controller.text,
                                  );
                                  }
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      hoverColor: AppConstants.hoverColor,
      backgroundColor: AppColors.highLight,
      splashColor: AppConstants.splashColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
      ),
      onPressed: ((){
        signUpDialogBuilder(context);
      }),
      child:  const ListTile(
        leading: Icon(
          Icons.account_circle_rounded,
          color: AppColors.fontDark,
        ),
        title: Text(
          "Sign up",
          style: TextStyle(
            color:AppColors.fontDark,
          ),
        ),
      ),
    );
  }
}
