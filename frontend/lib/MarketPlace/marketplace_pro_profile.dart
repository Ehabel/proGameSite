import 'package:charles_warburton/Account/widget/star_display_rating.dart';
import 'package:charles_warburton/Cart/requests/cart_requests.dart';
import 'package:charles_warburton/MarketPlace/models/gamepro_model.dart';
import 'package:charles_warburton/MarketPlace/widget/button.dart';
import 'package:charles_warburton/MarketPlace/widget/pro_profile.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'package:charles_warburton/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../Account/widget/text_star_rating.dart';
import '../Notifications/widget/text_notification_heading.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class MarketPlaceProfile extends StatefulWidget {
  late Users user;
  MarketPlaceProfile({Key? key, required this.user}) : super(key: key);


  @override
  State<MarketPlaceProfile> createState() => _MarketPlaceProfileState();
}

class _MarketPlaceProfileState extends State<MarketPlaceProfile> {
  final _profileScrollBarkey = GlobalKey();
  final PageController pageController = PageController();
  late int profileImagesIndex = 0;
  late double scrollBarWidth = 0;
  getPageIndex(){
    return pageController.page!;
  }


  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if(_profileScrollBarkey.currentContext!=null&&scrollBarWidth==0){
        setState(() {
          scrollBarWidth = _profileScrollBarkey.currentContext!.size!.width;
        });
      }
    });
    widget.user;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [AppConstants.shadow]
        ),
        constraints: const BoxConstraints(
          maxWidth: AppConstants.maxWidth,
        ),
        child: Column(
          children: [
            // profile images ListView
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  key: _profileScrollBarkey,
                  height: Dimensions.marketPlaceProfileHeight,
                  width: double.maxFinite,
                  color: AppColors.secondaryBackGroundDark,
                  child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    controller: pageController,
                    itemCount: AppImages.profileImages.length,
                    pageSnapping: true,
                    onPageChanged: ((page){
                      setState(() {
                        profileImagesIndex = page;
                      });
                    }),
                    itemBuilder: ((BuildContext context, int index) {
                      return Image.network(
                        AppImages.profileImages[index],
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                ),
                _profileScrollBarkey.currentContext!=null?
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.marketPlaceProfilePadding,
                    right: Dimensions.marketPlaceProfilePadding,
                    top: Dimensions.marketPlaceProfilePadding/2,
                    bottom: Dimensions.marketPlaceProfilePadding/2,
                  ),
                  child: AnimatedSize(
                    alignment: Alignment.bottomLeft,
                    curve: Curves.bounceInOut,
                    duration: const Duration(milliseconds: AppConstants.buttonIconDuration),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.profileImagesScrollBar,
                        borderRadius: BorderRadius.circular(Dimensions.marketPlaceProfileImagesScrollBarHeight/4),
                      ),
                      height: Dimensions.marketPlaceProfileImagesScrollBarHeight,
                      width: (scrollBarWidth/(AppImages.profileImages.length))*(profileImagesIndex+1),
                    ),
                  ),
                )

                    :
                Container(),
              ],
            ),
            Column(
              children: [
                Container(
                  color: AppColors.secondaryBackGroundDark,
                  // height: Dimensions.marketPlaceProfileAboutHeight,
                  padding: EdgeInsets.only(
                    top: Dimensions.paddingTop/2,
                    right:  Dimensions.paddingRight/2,
                    left:  Dimensions.paddingLeft/2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: Dimensions.paddingBottom/2,
                        ),
                        child: TextNotificationHeading(text: widget.user.email == null ? "No email" : widget.user!.email!,),
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: Dimensions.paddingRight/4,
                            ),
                            child: TextStarRating(text: widget.user.rating == null ? "No rating" : widget.user!.rating!.toString() ,),
                          ),
                          DisplayStarRating(rating: widget.user.rating == null ? 0 : widget.user!.rating!/5, numberOfStars: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: Dimensions.edgeInsetsAllSmall,
                  color: AppColors.secondaryBackGroundDark,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            right: Dimensions.paddingRight/8,
                          ),
                          child: ProProfileViewButton(proProfilePk: widget.user!.id!,),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.paddingRight/8,
                          ),
                          child: ButtonMarketPlace(
                            icon: Icons.monetization_on_rounded,
                            onPressed: (() {
                              CartRequests.addToCart(widget.user!.id!);
                            }),
                            label: 'Add to Cart',
                            radius: Dimensions.marketPlaceProfileButtonHeight/4,
                            color: AppColors.good,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
