import 'dart:typed_data';
import 'package:charles_warburton/Account/widget/edit_enum.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_sub_heading.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import 'game_image.dart';

typedef IntValue = void Function(int);
typedef ImageIndexValue = void Function(Uint8List, int);

class GameImages extends StatefulWidget {
  late List<bool> missingImages;
  late EditProfileType editProfileType;
  late List<Uint8List?> images;
  final List<String> title;
  final IntValue callBackRemoveImageAt;
  final ImageIndexValue callBackImage;
  GameImages({Key? key,
    required this.editProfileType,
    required this.images,
    required this.title,
    required this.missingImages,
    required this.callBackRemoveImageAt,
    required this.callBackImage,
  }) : super(key: key);

  @override
  State<GameImages> createState() => _GameImagesState();
}

class _GameImagesState extends State<GameImages> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.accountImage+Dimensions.paddingBottom/2+Dimensions.paddingTop/2,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.secondaryBackGroundDark,
          borderRadius: BorderRadius.circular(Dimensions.radiusSecondary)
      ),
      margin: EdgeInsets.only(
        top: Dimensions.paddingTop/2,
      ),
      padding: EdgeInsets.only(
        top: Dimensions.paddingTop/2,
        bottom: Dimensions.paddingBottom/2,
      ),
      constraints: const BoxConstraints(
        maxWidth: AppConstants.maxWidth,
      ),
      child: RawScrollbar(
        radius: Radius.circular(Dimensions.scrollBarThickness/6),
        thickness: Dimensions.scrollBarThickness/2,
        thumbColor: AppColors.scrollBar,
        padding: EdgeInsets.only(
          left: Dimensions.paddingLeft/2,
          right: Dimensions.paddingRight/2,
          bottom: -Dimensions.paddingBottom/4+Dimensions.scrollBarThickness/4,
        ),
        controller: scrollController,
        child: ListView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          children: List.generate(widget.images.length, (index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextNotificationSubHeading(text: widget.title[index], color: widget.missingImages[index]==true? AppColors.bad : AppColors.fontDark,),
              GameImage(
                image: widget.images[index],
                position: ListPosition.start,
                editProfileType: widget.editProfileType,
                callBackRemoveImage: ((){
                  widget.callBackRemoveImageAt(index);
                }),
                callBackImage: ((callBackImage){
                  widget.callBackImage(callBackImage, index);
                }),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
