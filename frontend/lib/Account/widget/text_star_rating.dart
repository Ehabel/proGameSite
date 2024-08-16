import 'package:charles_warburton/utils/constants.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class TextStarRating extends StatelessWidget {
  final String text;
  const TextStarRating({Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimensions.starRatingHeight,
      decoration: BoxDecoration(
          color: AppColors.starRatingBackground,
          borderRadius: BorderRadius.circular(Dimensions.starRatingHeight/2),
      ),
      padding: EdgeInsets.only(
        top: Dimensions.height5/2,
        bottom: Dimensions.height5/2,
        left: Dimensions.width5,
        right: Dimensions.width5,
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.highLight,
          fontFamily: AppConstants.fontMain,
          fontWeight: AppConstants.fontWeightHeading,
          fontSize: Dimensions.font25,
        ),
      ),
    );
  }
}
