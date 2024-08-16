import 'package:charles_warburton/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

typedef VoidValue = void Function();

class GameSelectionImage extends StatelessWidget {
  late bool isSelected;
  final String image;
  final String imageIsSelected;
  final VoidValue onPressed;
  GameSelectionImage({Key? key,
    required this.isSelected,
    required this.image,
    required this.imageIsSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstCurve: Curves.fastLinearToSlowEaseIn,
      crossFadeState: isSelected?CrossFadeState.showFirst:CrossFadeState.showSecond,
      duration: const Duration(milliseconds: AppConstants.buttonIconDuration),
      firstChild: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.secondaryBackGroundLight,
        child: FloatingActionButton(
          elevation: 0,
          hoverColor: AppColors.buttonSplash,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
          ),
          splashColor: AppColors.buttonSplash,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            child: Image.asset(
              imageIsSelected,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      secondChild: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.secondaryBackGroundDark,
        child: FloatingActionButton(
          elevation: 0,
          onPressed: onPressed,
          hoverColor: AppColors.secondaryBackGroundDark,
          splashColor: AppColors.buttonSplash,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
          ),
          child: ClipRRect(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
