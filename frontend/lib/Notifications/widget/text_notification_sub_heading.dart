import 'package:charles_warburton/utils/constants.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class TextNotificationSubHeading extends StatelessWidget {
  final String text;
  late Color color;
  TextNotificationSubHeading({Key? key,
    required this.text,
    this.color=AppColors.fontDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontFamily: AppConstants.fontMain,
        fontWeight: AppConstants.fontWeightLogo,
        fontSize: Dimensions.font15,
      ),
    );
  }
}
