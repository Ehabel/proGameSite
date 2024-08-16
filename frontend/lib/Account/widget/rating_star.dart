import 'package:charles_warburton/Account/widget/star_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

typedef IntValue = void Function(int);

class RatingStar extends StatefulWidget {
  late int numberOfStars;
  final IntValue callBackStarRating;
  RatingStar({Key? key,
    required this.numberOfStars,
    required this.callBackStarRating,
  }) : super(key: key);

  @override
  State<RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  late List<bool> selection = List.generate(widget.numberOfStars, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(widget.numberOfStars, (index) =>
          StarButton(
            star: index<=selection.indexWhere((selection)=> selection==true)? StarType.fullStar : StarType.emptyStar,
            buttonPosition: index==0?ButtonPosition.start:index==widget.numberOfStars-1?ButtonPosition.end:ButtonPosition.middle,
            onPressed: ((){
              setState(() {
                selection = List.generate(widget.numberOfStars, (index) => false);
                selection[index] = true;
              });
              widget.callBackStarRating(selection.indexWhere((selection)=> selection==true)+1);
            }),
          ),
      ),
    );
  }
}
