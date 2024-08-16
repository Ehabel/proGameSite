import 'package:charles_warburton/Account/widget/account_bio.dart';
import 'package:charles_warburton/Account/widget/edit_enum.dart';
import 'package:charles_warburton/Account/widget/models/pro_model.dart';
import 'package:charles_warburton/Account/widget/requests/account_requests.dart';
import 'package:charles_warburton/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

import '../../Notifications/widget/text_notification_heading.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import 'button.dart';

class ProProfileViewButton extends StatefulWidget {
  int proProfilePk;
  ProProfileViewButton({Key? key,
    required this.proProfilePk,
  }) : super(key: key);

  @override
  State<ProProfileViewButton> createState() => _ProProfileViewButtonState();
}

class _ProProfileViewButtonState extends State<ProProfileViewButton> {
  ProModel? proProfile;
  Future<void> showProProfileDialogBuilder(BuildContext context) {
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
            // padding: EdgeInsets.only(top: Dimensions.paddingTop),
            alignment: Alignment.center,
            child:  Column(
              children: [
              Container(
              height: Dimensions.height200,
              width: Dimensions.height200,
              margin: EdgeInsets.all(Dimensions.icon30/5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                child: material.Image.network(
                  AppImages.pro,
                  fit: BoxFit.cover,
                ),
              ),
            ),
              TextNotificationHeading(text: (proProfile!.fName! == null || proProfile!.lName! == null) ? "Text" :  "${proProfile!.fName!} ${proProfile!.lName!}",),
              ],
            )
          ),
          content: SingleChildScrollView(
            child:  Container(
              width: AppConstants.maxWidth*0.75,
              margin: Dimensions.edgeInsetsHorizontal,
              padding: Dimensions.edgeInsetsVertical,
              child: Column(
                children: [
                  ButtonMarketPlace(
                    icon: Icons.monetization_on_rounded,
                    onPressed: (() {}),
                    label: 'Add to Cart',
                    radius: Dimensions.marketPlaceProfileButtonHeight/4,
                    color: AppColors.good,
                  ),
                  AccountBio(text: proProfile!.description == null ? "Enter a bio" : proProfile!.description!, editProfileType: EditProfile.normalMode, callBackText: ((bioText) {}),),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void _firstLoad() {
    GetPro(
      proProfilePk: widget.proProfilePk,
        callBackError: (statusCode) {
          print("Error: $statusCode");
        },
        callBackProProfile: (proModel) {
          setState(() {
              proProfile = proModel;
              showProProfileDialogBuilder(context);
          });
      }
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ButtonMarketPlace(
      onPressed: (() {
        _firstLoad();
      }),
      label: 'Profile',
      icon: Icons.account_circle_rounded,
      radius: Dimensions.marketPlaceProfileButtonHeight/4,
      color: AppColors.highLight,
    );
  }
}
