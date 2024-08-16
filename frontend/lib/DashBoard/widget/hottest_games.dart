import 'package:charles_warburton/DashBoard/widget/popular_modal_body.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class PopularGames extends StatefulWidget {
  const PopularGames({Key? key}) : super(key: key);

  @override
  State<PopularGames> createState() => _PopularGamesState();
}

class _PopularGamesState extends State<PopularGames> {
  Future<void> popularGamesDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: AppColors.fontDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
          ),
          backgroundColor: AppColors.secondaryBackGroundDark,
          title: Container(
            padding: EdgeInsets.only(top: Dimensions.paddingTop),
            alignment: Alignment.center,
            child:  const TextNotificationHeading(text: "Hottest 10 Games",),
          ),
          content: const SizedBox(
            width: AppConstants.maxWidth*0.75,
            child: PopularGamesModalBody(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      hoverColor: AppConstants.hoverColor,
      backgroundColor: AppColors.highLight,
      splashColor: AppConstants.splashColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
      ),
      onPressed: ((){
        popularGamesDialogBuilder(context);
      }),
      child:  const ListTile(
        leading: Icon(
          Icons.local_fire_department_sharp,
          color: AppColors.fontDark,
        ),
        title: Text(
          "Hottest 10 Games",
          style: TextStyle(
            color:AppColors.fontDark,
          ),
        ),
      ),
    );
  }
}
