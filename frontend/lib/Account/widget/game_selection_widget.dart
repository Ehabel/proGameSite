import 'package:charles_warburton/Notifications/widget/text_notification_sub_heading.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

typedef BoolValue = void Function(bool?);

class ProGameSelection extends StatefulWidget {
  final String name;
  final String image;
  final int gamePk;
  late bool? checkBoxValue;
  final BoolValue callBackCheckBoxValue;
  ProGameSelection({Key? key,
    required this.name,
    required this.image,
    required this.gamePk,
    required this.checkBoxValue,
    required this.callBackCheckBoxValue,
  }) : super(key: key);

  @override
  State<ProGameSelection> createState() => _ProGameSelectionState();
}

class _ProGameSelectionState extends State<ProGameSelection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height65,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.paddingLeft/2
            ),
            child: Checkbox(
              activeColor: AppColors.highLight,
                value: widget.checkBoxValue, onChanged: ((value){
                  setState(() {
                    widget.checkBoxValue = value;
                  });
                widget.callBackCheckBoxValue(widget.checkBoxValue);
              })),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimensions.paddingLeft/2
              ),
              child: TextNotificationSubHeading(text: widget.name),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: Dimensions.paddingRight/2,
                left: Dimensions.paddingLeft/2,
            ),
            height: Dimensions.height45,
            width: Dimensions.width60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.height45/4),
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

