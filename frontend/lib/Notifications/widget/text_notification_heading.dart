import 'package:charles_warburton/utils/constants.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class TextNotificationHeading extends StatelessWidget {
  final String text;
  const TextNotificationHeading({Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.fontDark,
        fontFamily: AppConstants.fontMain,
        fontWeight: AppConstants.fontWeightHeading,
        fontSize: Dimensions.font25,
      ),
    );
  }
}
