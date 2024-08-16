import 'package:charles_warburton/Account/widget/edit_enum.dart';
import 'package:charles_warburton/Account/widget/requests/account_requests.dart';
import 'package:charles_warburton/utils/images.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import 'account_image.dart';

class AccountImages extends StatefulWidget {
  late EditProfileType editProfileType;
  late List<String>? images;
  AccountImages({Key? key,
    required this.editProfileType,
    required this.images,
  }) : super(key: key);

  @override
  State<AccountImages> createState() => _AccountImagesState();
}

class _AccountImagesState extends State<AccountImages> {
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
          children: List.generate(widget.images!.length+(widget.editProfileType==EditProfileType.editMode?1:0), (index) => AccountImage(
            image: index>widget.images!.length-1?null:widget.images![index],
            position: index==0?ListPosition.start:index==widget.images!.length?ListPosition.end:ListPosition.middle,
            callBackRemoveImage: ((){
              setState(() {
                widget.images!.removeAt(index);
              });
            }),
            callBackImage: ((){
              AccountRequests.getUserAccountImage().then((imageUrl) {
                setState(() {
                  List<String> imageUrlList = imageUrl.split(',');
                  for (String loc in imageUrlList) {
                    widget.images!.add(imageUrl);
                  }
                });
              }).catchError((error) {
                print('Error occurred: $error');
              });
            }),
            editProfileType: widget.editProfileType,
          ),),
        ),
      ),
    );
  }
}
