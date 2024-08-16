import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

enum StarType {
  fullStar,
  halfStar,
  emptyStar,
}

class Star {
  static const StarType fullStar = StarType.fullStar;
  static const StarType halfStar = StarType.halfStar;
  static const StarType emptyStar = StarType.emptyStar;
}

enum ButtonPosition {
  start,
  middle,
  end,
}

class ButtonPos {
  static const ButtonPosition start = ButtonPosition.start;
  static const ButtonPosition middle = ButtonPosition.middle;
  static const ButtonPosition end = ButtonPosition.end;
}

typedef VoidValue = void Function();

class StarButton extends StatelessWidget {
  final StarType star;
  late VoidValue onPressed;
  final ButtonPosition buttonPosition;
  StarButton({Key? key,
    required this.star,
    required this.buttonPosition,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimensions.starRatingHeight,
      width: Dimensions.starRatingHeight,
      decoration: BoxDecoration(
        color: AppColors.backGroundDark,
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
      child: FloatingActionButton(
        splashColor: AppColors.buttonSplash,
        backgroundColor: Colors.transparent,
        onPressed: onPressed,
        child: Icon(
          star==Star.fullStar?Icons.star:star==Star.halfStar?Icons.star_half_outlined:Icons.star_border_outlined,
          color: AppColors.starRating,
          size: Dimensions.starRatingIcon,
        ),
      ),
    );
  }
}
