import 'package:charles_warburton/Account/widget/requests/account_requests.dart';
import 'package:charles_warburton/Account/widget/star_display_rating.dart';
import 'package:charles_warburton/Account/widget/text_star_rating.dart';
import 'package:flutter/material.dart';
import '../../DashBoard/dashboard.dart';
import '../../Notifications/widget/text_notification_heading.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import 'button_account.dart';
import 'edit_enum.dart';
import 'package:flutter/material.dart' as material;

typedef CallBackEditProfileType = void Function(EditProfileType);

class AccountHeader extends StatelessWidget {
  late String userName;
  late double userRating;
  late String imageUrl;
  late ScreenSizeType screenWidth;
  late EditProfileType editProfileType;
  final CallBackEditProfileType callBackEditProfileType;
  AccountHeader({Key? key,
    required this.userName,
    required this.userRating,
    required this.imageUrl,
    required this.screenWidth,
    required this.editProfileType,
    required this.callBackEditProfileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondaryBackGroundDark,
          borderRadius: BorderRadius.circular(Dimensions.radiusSecondary)
      ),
      padding: Dimensions.edgeInsetsAllSmall,
      constraints: const BoxConstraints(
        maxWidth: AppConstants.maxWidth,
      ),
      child: Column(
        children: [
          Flex(
            direction: screenWidth==ScreenSize.large? Axis.horizontal : Axis.vertical,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.accountProfilePictureHeight/2),
                child: Container(
                  height: Dimensions.accountProfilePictureHeight,
                  width: Dimensions.accountProfilePictureWidth,
                  color: AppColors.secondaryBackGroundDark,
                  child: Image.network(imageUrl),
                ),
              ),
              screenWidth==ScreenSize.large?
              Expanded(
                child: Container(
                  height: Dimensions.accountProfilePictureHeight,
                  margin: EdgeInsets.only(
                    left: Dimensions.paddingLeft/2,
                  ),
                  padding: Dimensions.edgeInsetsAllSmall,
                  decoration: BoxDecoration(color: AppColors.backGroundDarkLight,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSecondary)
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: Dimensions.paddingBottom/2,
                        ),
                        child: TextNotificationHeading(text: userName,),
                      ),
                      Flex(

                        direction: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              TextStarRating(text: '${userRating}',),
                              Expanded(child: Container()),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: Dimensions.paddingRight/4,
                                ),
                                child:  DisplayStarRating(rating: userRating/5, numberOfStars: AppConstants.rating),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
                  :
              Container(
                margin: EdgeInsets.only(
                  top: Dimensions.paddingTop/2,
                ),
                padding: Dimensions.edgeInsetsAllSmall,
                decoration: BoxDecoration(color: AppColors.backGroundDarkLight,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: Dimensions.paddingBottom/2,
                      ),
                      child: TextNotificationHeading(text: userName,),
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Row(
                          children: [
                            TextStarRating(text: '${userRating*AppConstants.rating}',),
                            Expanded(child: Container(),),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Dimensions.paddingTop/4,
                          ),
                          child: Row(
                            children: [
                              DisplayStarRating(rating: userRating, numberOfStars: AppConstants.rating),
                              Expanded(child: Container(),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.paddingTop/2
            ),
            child: Row(
              children: [
                ButtonAccount(
                  onPressed:((){
                    callBackEditProfileType(editProfileType==EditProfileType.normalMode?EditProfileType.editMode:EditProfileType.normalMode);
                  }),
                  label: editProfileType==EditProfileType.normalMode?"Edit Profile":"Done",
                  radius: Dimensions.accountButtonHeight/4,
                  color: editProfileType==EditProfileType.normalMode?AppColors.highLight:AppColors.good,
                  icon: editProfileType==EditProfileType.normalMode?Icons.edit:Icons.save,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.paddingTop/2,
                    ),
                    child: ButtonAccount(
                      onPressed:((){
                        AccountRequests.becomeAPro();
                      }),
                      label: "Become Pro",
                      radius: Dimensions.accountButtonHeight/4,
                      color: AppColors.good,
                      icon: Icons.videogame_asset_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
