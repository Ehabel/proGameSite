import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Dimensions{
  static EdgeInsets edgeInsetsAllSmall = EdgeInsets.only(
    left: Dimensions.marketPlaceProfilePadding,
    right: Dimensions.marketPlaceProfilePadding,
    top: Dimensions.marketPlaceProfilePadding,
    bottom: Dimensions.marketPlaceProfilePadding,
  );
  static EdgeInsets edgeInsetsAll = EdgeInsets.only(
    left: Dimensions.paddingLeft,
    right: Dimensions.paddingRight,
    top: Dimensions.paddingTop,
    bottom: Dimensions.paddingBottom,
  );
  static EdgeInsets edgeInsetsVertical = EdgeInsets.only(
    top: Dimensions.paddingTop,
    bottom: Dimensions.paddingBottom,
  );
  static EdgeInsets edgeInsetsHorizontal = EdgeInsets.only(
    left: Dimensions.paddingLeft,
    right: Dimensions.paddingRight,
  );
  static double marketPlaceProfileHeight = marketPlaceProfilePictureHeight+
      marketPlaceProfilePadding+
      marketPlaceProfilePadding+
      marketPlaceProfileButtonHeight;
  static double starRatingIcon = icon30;
  static double starRatingHeight = height5+icon30;
  static double accountProfilePictureHeight = height200;
  static double accountProfilePictureWidth = height200;
  static double accountButtonHeight = height50;
  static double marketPlaceProfileButtonHeight = height50;
  static double marketPlaceProfileImagesScrollBarHeight = height10;
  static double marketPlaceProfilePictureHeight = height120;
  static double marketPlaceProfileAboutHeight = height90;
  static double marketPlaceProfilePadding = screenHeight/61.73333;
  static double navigationButtonPadding = height1*3;
  static double navigationButtonFontSize = font10;
  static double gameSelectionImageHeight = height100;
  static double gameSelectionImageHeightSelected = height120;
  static double gameSelectionImageWidth = width150;
  static double paddingRight = screenHeight/30.86667;
  static double paddingLeft = screenHeight/30.86667;
  static double paddingTop = screenHeight/30.86667;
  static double paddingBottom = screenHeight/30.86667;

  static double paddingLogoBottom = screenHeight/185.2;
  static double logoHeight = screenHeight/23.15;
  static double paddingTextTop = screenHeight/185.2;
  static double paddingTextBottom = screenHeight/185.2;
  static double paddingItemCart = screenHeight/14.24615;
  static double gap = height20;
  static double storeImageHeight = height260;
  static double twoLineTextHeight = height30;
  static double accountImage = height120;
  static double videoPlayerButtonSize = height60;
  static double totalSalesHeight = screenHeight/3;
  static double scrollBarThickness = height1*8;

  static double largeBannerStoreHeight = height260;
  static double appBarLogoHeight = appBarHeight-height20;
  static double appBarHeight = height70;
  static double appBarRadius = 0;
  static double appBarBorderWidth = height1;
  static double bottomBarHeight = height70;
  static double paddingLeftGameSlider = paddingLeft/4;

  static double itemImagesHeight = height70;

  static double largeButtonWidth = screenWidth-paddingRight-paddingLeft;
  static double largeButtonheight = screenHeight/20.57778;
  static double mediumButtonHeight = screenHeight/23.15;

  static double paddingButtonTop = screenHeight/30.86667;

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  // 926/x = y
  // 926/130 = 7.12307
  static double pageViewContainer=screenHeight/7.12307;
  // 926/68 = 13.61765
  static double pageViewTextContainer=screenHeight/13.61765;
  // 926/60 = 15.43333
  static double pageViewCoverPhotoContainer=screenHeight/15.43333;
  // 926/75 = 12.34667
  static double pageViewPhotoBackgroundContainer=screenHeight/12.34667;
  // 926/70 = 13.22857
  static double pageViewPhotoContainer=screenHeight/13.22857;
  static double height1 = screenHeight/926;
  static double height2 = screenHeight/463;
  static double height5 = screenHeight/185.2;
  static double height10 = screenHeight/96.2;
  static double height15 = screenHeight/61.73333;
  static double height20 = screenHeight/46.3;
  static double height25 = screenHeight/37.04;
  static double height30 = screenHeight/30.86667;
  static double height34 = screenHeight/27.23529;
  static double height40 = screenHeight/23.15;
  static double height45 = screenHeight/20.57778;
  static double height50 = screenHeight/18.52;
  static double height55 = screenHeight/16.83636;
  static double height60 = screenHeight/15.43333;
  static double height65 = screenHeight/14.24615;
  static double height70 = screenHeight/13.22857;
  static double height75 = screenHeight/12.34667;
  static double height80 = screenHeight/11.575;
  static double height84 = screenHeight/11.02381;
  static double height86 = screenHeight/10.76744;
  static double height90 = screenHeight/10.28889;
  static double height100 = screenHeight/9.26;
  static double height110 = screenHeight/8.41818;
  static double height120 = screenHeight/7.71667;
  static double height130 = screenHeight/7.12308;
  static double height140 = screenHeight/6.61429;
  static double height150 = screenHeight/6.17333;
  static double height160 = screenHeight/5.7875;
  static double height170 = screenHeight/5.44706;
  static double height175 = screenHeight/5.29143;
  static double height180 = screenHeight/5.14444;
  static double height196 = screenHeight/4.72447;
  static double height200 = screenHeight/4.63;
  static double height220 = screenHeight/4.20909;
  static double height230 = screenHeight/4.02609;
  static double height240 = screenHeight/3.85833;
  static double height250 = screenHeight/3.704;
  static double height260 = screenHeight/3.56154;
  static double height263 = screenHeight/3.52091;
  static double height264 = screenHeight/3.50758;
  static double height265 = screenHeight/3.49434;
  static double height290 = screenHeight/3.19310;
  static double height300 = screenHeight/3.09667;
  static double height320 = screenHeight/2.89375;
  static double height380 = screenHeight/2.43684;
  static double height400 = screenHeight/2.315;
  static double height420 = screenHeight/2.20476;
  static double height616 = screenHeight/1.505691057;
  static double height700 = screenHeight/1.32286;

  static double sliderGap = screenHeight/2675;

  //width 428.0
  static double width2half = screenWidth/171.2;
  static double width5 = screenWidth/85.6;
  static double width10 = screenWidth/42.8;
  static double width15 = screenWidth/28.53333;
  static double width20 = screenWidth/21.4;
  static double width30 = screenWidth/14.26667;
  static double width40 = screenWidth/10.7;
  static double width45 = screenWidth/9.51111;
  static double width60 = screenWidth/7.13333;
  static double width70 = screenWidth/6.11429;
  static double width75 = screenWidth/5.70667;
  static double width80 = screenWidth/5.35;
  static double width90 = screenWidth/4.75556;
  static double width100 = screenWidth/4.28;
  static double width130 = screenWidth/3.29231;
  static double width110 = screenWidth/3.89091;
  static double width120 = screenWidth/3.56667;
  static double width150 = screenWidth/2.85333;
  static double width160 = screenWidth/2.675;
  static double width170 = screenWidth/2.51765;
  static double width190 = screenWidth/2.25263;
  static double width200 = screenWidth/2.14;
  static double width220 = screenWidth/1.94545;
  static double width250 = screenWidth/1.712;
  static double width350 = screenWidth/1.22286;
  static double width390 = screenWidth/1.09743;
  static double width320 = screenWidth/1.3375;
  static double width400 = screenWidth/1.07;

  static double font10 = screenHeight/92.6;
  static double font12 = screenHeight/77.16667;
  static double font15 = screenHeight/61.73333;
  static double font20 = screenHeight/46.3;
  static double font25 = screenHeight/37.04;
  static double font30 = screenHeight/30.86667;
  static double font35 = screenHeight/26.45714;
  static double radius20 = screenHeight/46.3;
  static double radiusMain = 100;
  static double radiusSecondary = screenHeight/46.3;

  static double icon10 = screenHeight/92.6;
  static double icon15 = screenHeight/61.73333;
  static double icon16 = screenHeight/57.875;
  static double icon20 = screenHeight/46.3;
  static double icon24 = screenHeight/38.58333;
  static double icon30 = screenHeight/30.86667;
  static double icon35 = screenHeight/26.45714;



  static double area80 = (screenHeight*screenWidth)/4954.1;
  static double area90 = (screenHeight*screenWidth)/4403.64444;
  static double area100 = (screenHeight*screenWidth)/3963.28;
  static double area110 = (screenHeight*screenWidth)/3602.98182;
  static double area120 = (screenHeight*screenWidth)/3302.73333;
  static double area150 = (screenHeight*screenWidth)/2642.18667;
  static double area170 = (screenHeight*screenWidth)/2331.34118;



}