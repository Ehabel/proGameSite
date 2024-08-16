import 'package:charles_warburton/Account/widget/star_button.dart';
import 'package:charles_warburton/Account/widget/star_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

typedef IntValue = void Function(int);

class DisplayStarRating extends StatelessWidget {
  final int numberOfStars;
  final double rating;
  const DisplayStarRating({Key? key,
    required this.rating,
    required this.numberOfStars,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.starRatingHeight/2),
        color: AppColors.starRatingBackground,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(numberOfStars, (index) =>
            StarDisplay(
              star: index+1<=numberOfStars*rating? StarType.fullStar : index+1>(numberOfStars*rating).ceil()? StarType.emptyStar : StarType.halfStar,
              buttonPosition: index==0?ButtonPosition.start:index==numberOfStars-1?ButtonPosition.end:ButtonPosition.middle,
            ),
        ),
      ),
    );
  }
}
