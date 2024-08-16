import 'package:charles_warburton/Account/widget/edit_enum.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_body.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';

typedef StringType = void Function(String);

class AccountBio extends StatefulWidget {
  final String text;
  late EditProfileType editProfileType;
  final StringType callBackText;
  AccountBio({Key? key,
    required this.text,
    required this.editProfileType,
    required this.callBackText,
  }) : super(key: key);

  @override
  State<AccountBio> createState() => _AccountBioState();
}

class _AccountBioState extends State<AccountBio> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = widget.text;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.secondaryBackGroundDark,
          borderRadius: BorderRadius.circular(Dimensions.radiusSecondary)
      ),
      margin: EdgeInsets.only(
        top: Dimensions.paddingTop/2,
      ),
      padding: Dimensions.edgeInsetsAllSmall,
      constraints: const BoxConstraints(
        maxWidth: AppConstants.maxWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: Dimensions.paddingBottom/2,
            ),
            child: Row(
              children: [
                const TextNotificationHeading(text: "Bio"),
                widget.editProfileType==EditProfileType.editMode?
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingLeft/2,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: AppColors.fontDark,
                  ),
                )
                    :
                Container(),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                child: AnimatedCrossFade(
                  firstChild: Container(
                    decoration: BoxDecoration(
                        color: AppColors.backGroundDark,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radiusSecondary),
                          bottomRight: Radius.circular(Dimensions.radiusSecondary),
                        )
                    ),
                    padding: Dimensions.edgeInsetsAllSmall,
                    child: TextField(
                      onChanged:  ((text){
                        widget.callBackText(textEditingController.text);
                      }),
                      maxLines: null,
                      controller: textEditingController,
                      style: TextStyle(
                        color: AppColors.fontDark,
                        fontFamily: AppConstants.fontMain,
                        fontSize: Dimensions.font12,
                      ),
                    ),
                  ),
                  secondChild: Text(
                    widget.text,
                    style: TextStyle(
                      color: AppColors.fontDark,
                      fontFamily: AppConstants.fontMain,
                      fontSize: Dimensions.font12,
                    ),
                  ),
                  crossFadeState: widget.editProfileType==EditProfileType.editMode?CrossFadeState.showFirst:CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: AppConstants.topBarDuration),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
