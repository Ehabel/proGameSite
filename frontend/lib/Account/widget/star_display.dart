import 'package:charles_warburton/Account/widget/star_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

typedef VoidValue = void Function();

class StarDisplay extends StatelessWidget {
  final StarType star;
  final ButtonPosition buttonPosition;
  const StarDisplay({Key? key,
    required this.star,
    required this.buttonPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimensions.starRatingHeight,
      width: Dimensions.starRatingHeight,
      decoration: BoxDecoration(
        borderRadius: buttonPosition==ButtonPosition.start?
        BorderRadius.only(
          topLeft: Radius.circular(Dimensions.starRatingHeight/2),
          bottomLeft: Radius.circular(Dimensions.starRatingHeight/2),
        )
            :
        buttonPosition==ButtonPosition.middle?
        const BorderRadius.only()
            :
        BorderRadius.only(
          topRight: Radius.circular(Dimensions.starRatingHeight/2),
          bottomRight: Radius.circular(Dimensions.starRatingHeight/2),
        ),
      ),
      padding: EdgeInsets.zero,
      child: Icon(
        star==Star.fullStar?Icons.star:star==Star.halfStar?Icons.star_half_outlined:Icons.star_border_outlined,
        color: AppColors.starRating,
        size: Dimensions.starRatingIcon,
      )
    );
  }
}
