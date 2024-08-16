import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';

typedef IntValue = void Function(int);

class BottomNavigationButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final int index;
  late List<bool> selections;
  final IntValue callBackSelections;
  final BorderRadius borderRadius;
  BottomNavigationButton({Key? key,
    required this.label,
    required this.icon,
    required this.index,
    required this.borderRadius,
    required this.selections,
    required this.callBackSelections,
  }) : super(key: key);

  @override
  State<BottomNavigationButton> createState() => _BottomNavigationButtonState();
}

class _BottomNavigationButtonState extends State<BottomNavigationButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: AppColors.buttonSplash,
      backgroundColor: AppColors.bottomNavigationButtonColor,
      elevation: 1,
      onPressed: ((){
        widget.callBackSelections(widget.index);
      }),
      shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            color: widget.selections[widget.index]?AppColors.bottomNavigationButtonIconSelectedColor:AppColors.bottomNavigationButtonIconColor,
            size: Dimensions.icon24,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: AppConstants.buttonIconDuration,),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: widget.selections[widget.index]?Dimensions.navigationButtonFontSize:0,
                fontFamily: AppConstants.fontMain,
                color: widget.selections[widget.index]?AppColors.bottomNavigationButtonIconSelectedColor:AppColors.bottomNavigationButtonIconColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
