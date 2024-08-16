import 'package:charles_warburton/Account/widget/star_display_rating.dart';
import 'package:charles_warburton/Account/widget/text_star_rating.dart';
import 'package:charles_warburton/DashBoard/models/popular_games_model.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';

class PopularGameResult extends StatefulWidget {
  final int index;
  final String gameName;
  final String image;
  final double rating;
  final int highestRating;
  final List<Platforms> platforms;
  const PopularGameResult({Key? key,
    required this.index,
    required this.gameName,
    required this.image,
    required this.rating,
    required this.highestRating,
    required this.platforms,
  }) : super(key: key);

  @override
  State<PopularGameResult> createState() => _PopularGameResultState();
}

class _PopularGameResultState extends State<PopularGameResult> {
  late bool isPlaystationAdded = false;
  late bool isXboxAdded = false;
  late bool isNintendoAdded = false;
  late bool isPcAdded = false;
  _getPlatformIconString(String platform){
    if(platform.toLowerCase().contains("playstation") && !isPlaystationAdded){
      setState(() {
        isPlaystationAdded = true;
      });
      return Container(
        height: Dimensions.height20,
        padding: EdgeInsets.only(
          right: Dimensions.paddingRight/2,
        ),
        child: Image.asset(AppImages.playstationLogo),
      );
    }
    else if(platform.toLowerCase().contains("xbox") && !isXboxAdded){
      setState(() {
        isXboxAdded = true;
      });
      return Container(
        height: Dimensions.height20,
        padding: EdgeInsets.only(
          right: Dimensions.paddingRight/2,
        ),
        child: Image.asset(AppImages.xboxLogo),
      );
    }
    else if(platform.toLowerCase().contains("nintendo") && !isNintendoAdded){
      setState(() {
        isNintendoAdded = true;
      });
      return Container(
        height: Dimensions.height20,
        padding: EdgeInsets.only(
          right: Dimensions.paddingRight/2,
        ),
        child: Image.asset(AppImages.nintendoLogo),
      );
    }
    else if(platform.toLowerCase().contains("pc") && !isPcAdded){
      setState(() {
        isPcAdded = true;
      });
      return Container(
        height: Dimensions.height20,
        padding: EdgeInsets.only(
          right: Dimensions.paddingRight/2,
        ),
        child: Container(
          alignment: Alignment.topCenter,
          child: Text(
              "PC",
            style: TextStyle(
              inherit: true,
              fontFamily: AppConstants.fontMain,
              fontSize: Dimensions.height1*18,
              fontWeight: AppConstants.fontWeightHeading,
              color: AppColors.fontDark,
            ),
          ),
        ),
      );
    }
    return Container();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextNotificationHeading(text: widget.gameName),
        Container(
          padding: EdgeInsets.only(
            top: Dimensions.paddingTop/2,
            bottom: Dimensions.paddingBottom/2,
          ),
          child: Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: Dimensions.paddingRight/4,
                  ),
                  child: DisplayStarRating(rating: widget.rating, numberOfStars: widget.highestRating),
                ),
                TextStarRating(text: (widget.rating*widget.highestRating).toString()),
                Expanded(child: Container(),),
              ]
          ),
        ),
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              height: Dimensions.height200,
              width: double.maxFinite,
              child:  Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ]
                ),
              ),
              padding: Dimensions.edgeInsetsAllSmall,
              child: TextNotificationHeading(text: "#${widget.index}"),
            ),
          ],
        ),
        Row(
          children:
          List.generate(widget.platforms.length, (index) => Container(
            margin: EdgeInsets.only(
              top: Dimensions.height5,
              bottom: Dimensions.height5,
            ),
            child: _getPlatformIconString(widget.platforms[index].platform!.name.toString()),
          )),
        )
      ],
    );
  }
}

