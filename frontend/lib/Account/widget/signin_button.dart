import 'package:charles_warburton/DashBoard/models/login_model.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../DashBoard/requests/dashboard_requests.dart';
import '../../MarketPlace/widget/button.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

typedef VoidValue = void Function();

class SignInButtonAccount extends StatefulWidget {
  VoidValue callBackSignin;
  IconData icon;
  Color color;
  String label;
  double radius;
  SignInButtonAccount({Key? key,
    required this.label,
    required this.color,
    required this.icon,
    required this.radius,
    required this.callBackSignin,
  }) : super(key: key);

  @override
  State<SignInButtonAccount> createState() => _SignInButtonAccountState();
}

class _SignInButtonAccountState extends State<SignInButtonAccount> {
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginModel? loginModel;
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
            child:  const TextNotificationHeading(text: "Login",),
          ),
          content: SingleChildScrollView(
            child:  Container(
              width: AppConstants.maxWidth*0.75,
              margin: Dimensions.edgeInsetsAll,
              padding: Dimensions.edgeInsetsAll,
              child: Form(
                  key: _formKey,
                  child:  Column(
                    children: [
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
                        controller: passwordController,
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
                                label: "Login",
                                icon: Icons.check_circle_rounded,
                                radius: Dimensions.radius20,
                                color: AppColors.good,
                                onPressed: (() {
                                  GetLogin(
                                    callBackLogin: (loginModel) {
                                      widget.callBackSignin();
                                      Navigator.pop(context);
                                    },
                                    callBackError: (statusCode) {
                                      print("Error: $statusCode");
                                    },
                                    email: emailController.text,
                                    password: passwordController.text,
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
    // TODO: implement dispose;
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ButtonMarketPlace(
      onPressed: ((){
        signUpDialogBuilder(context);
      }),
      label: widget.label,
      radius: widget.radius,
      color: widget.color,
      icon: widget.icon,
    );
  }
}
