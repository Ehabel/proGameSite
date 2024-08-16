import 'package:flutter/cupertino.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CustomScrollBar extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;
  late EdgeInsets padding;
  CustomScrollBar({Key? key,
    required this.scrollController,
    required this.child,
    this.padding=EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      padding: padding,
      radius: Radius.circular(Dimensions.scrollBarThickness/4),
      thickness: Dimensions.scrollBarThickness,
      thumbColor: AppColors.scrollBar,
      controller: scrollController,
        child: child,
    );
  }
}
