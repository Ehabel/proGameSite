import 'package:charles_warburton/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
typedef VoidValue = void Function();
class ButtonAccount extends StatelessWidget {
  final VoidValue onPressed;
  final String label;
  final double radius;
  late Color color;
  late IconData? icon;
  ButtonAccount({Key? key,
    required this.onPressed,
    required this.label,
    required this.radius,
    required this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: color,
      splashColor: AppColors.buttonSplash,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius)
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.fontLight,
        size: Dimensions.font20,
      ),
      label: Text(
        label,
        style: TextStyle(
            color: AppColors.fontLight,
            inherit: false,
            fontFamily: AppConstants.fontMain,
            fontSize: Dimensions.font15,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
