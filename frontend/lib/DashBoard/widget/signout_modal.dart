import 'package:charles_warburton/DashBoard/models/login_model.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../MarketPlace/widget/button.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../requests/dashboard_requests.dart';

typedef VoidValue = void Function();

class SignOutButton extends StatefulWidget {
  VoidValue callBackSignOut;
  SignOutButton({Key? key,
    required this.callBackSignOut,
  }) : super(key: key);

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  Future<void> signOutDialogBuilder(BuildContext context) {
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
            child:  const TextNotificationHeading(text: "Sign Out",),
          ),
          content: SingleChildScrollView(
            child:  Container(
              width: AppConstants.maxWidth*0.75,
              margin: Dimensions.edgeInsetsAll,
              padding: EdgeInsets.only(
                left: Dimensions.paddingLeft,
                right: Dimensions.paddingRight,
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
                      label: "Sign Out",
                      icon: Icons.logout_rounded,
                      radius: Dimensions.radius20,
                      color: AppColors.bad,
                      onPressed: (() {
                        widget.callBackSignOut();
                        Navigator.pop(context);
                      }),
                    ),
                  ),
                ],
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
        signOutDialogBuilder(context);
      }),
      child:  const ListTile(
        leading: Icon(
          Icons.logout_rounded,
          color: AppColors.fontDark,
        ),
        title: Text(
          "Sign Out",
          style: TextStyle(
            color:AppColors.fontDark,
          ),
        ),
      ),
    );
  }
}
