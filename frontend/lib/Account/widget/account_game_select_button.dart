import 'package:charles_warburton/Account/widget/requests/account_requests.dart';
import 'package:charles_warburton/DashBoard/models/login_model.dart';
import 'package:charles_warburton/MarketPlace/widget/custom_scroll_bar.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_body.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:charles_warburton/utils/images.dart';
import 'package:flutter/material.dart';

import '../../DashBoard/requests/dashboard_requests.dart';
import '../../MarketPlace/widget/button.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'game_selection_widget.dart';
import 'models/game_selection.dart';

typedef VoidValue = void Function();

class GameSelectButtonAccount extends StatefulWidget {
  VoidValue callBackSelectedGame;
  IconData icon;
  Color color;
  String label;
  double radius;
  GameSelectButtonAccount({Key? key,
    required this.label,
    required this.color,
    required this.icon,
    required this.radius,
    required this.callBackSelectedGame,
  }) : super(key: key);

  @override
  State<GameSelectButtonAccount> createState() => _GameSelectButtonAccountState();
}

class _GameSelectButtonAccountState extends State<GameSelectButtonAccount> {
  late GameSelectionModel? gameSelectionModel;
  final ScrollController _scrollController = ScrollController();
  late int? selectedGamePkIndex;
  late int selectedGamePk;
  late bool noGamePk = false;
  late List<bool?> checkButtons  = [false, false, false, false];
  void _firstLoad(){
    GetAllGames(
      callBackAllGamesSelection: ((gamesModel){
        setState(() {
          gameSelectionModel = gamesModel;
        });
      }),
      callBackError: ((error){
        print("Error with getting all games for pro selection Error: $error");
      })
    );
  }

  Future<void> addGameDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return AlertDialog(
              surfaceTintColor: AppColors.fontDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
              ),
              backgroundColor: AppColors.secondaryBackGroundDark,
              title: Container(
                padding: EdgeInsets.only(top: Dimensions.paddingTop),
                alignment: Alignment.center,
                child:  const TextNotificationHeading(text: "Pro Game Select",),
              ),
              content: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      height: Dimensions.height260,
                      width: AppConstants.maxWidth*0.75,
                      margin: Dimensions.edgeInsetsAll,
                      padding: Dimensions.edgeInsetsAll,
                      child: CustomScrollBar(
                        scrollController: _scrollController,
                        child: ListView.builder(
                          itemCount: gameSelectionModel!.dataList.length,
                          itemBuilder: ((context, index){
                            return ProGameSelection(
                              name: gameSelectionModel!.dataList[index].gameName!,
                              image: gameSelectionModel!.dataList[index].gameIconDark!,
                              gamePk: gameSelectionModel!.dataList[index].gameId!,
                              checkBoxValue: gameSelectionModel!.dataList[index].isSelected,
                              callBackCheckBoxValue: ((callBackCheckBoxValue){
                                if(callBackCheckBoxValue == true){
                                  for(int i = 0; i < gameSelectionModel!.dataList.length; i++){
                                    setState((){
                                      gameSelectionModel!.dataList[i].isSelected = false;
                                    });
                                  }
                                }
                                setState((){
                                  gameSelectionModel!.dataList[index].isSelected = callBackCheckBoxValue!;
                                });
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                    noGamePk?
                    TextNotificationBody(text: 'Select a Game',color: AppColors.bad,)
                        :
                    Container(),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonMarketPlace(
                            onPressed: ((){
                              Navigator.pop(context);
                            }),
                            label: "Cancel",
                            icon: Icons.cancel_rounded,
                            radius: Dimensions.marketPlaceProfileButtonHeight/4,
                            color: AppColors.bad,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: Dimensions.paddingLeft/4,
                            ),
                            child: ButtonMarketPlace(
                              onPressed: ((){
                                for(int index = 0; index < gameSelectionModel!.dataList.length; index++){
                                  if(gameSelectionModel!.dataList[index].isSelected ==true ){
                                    setState((){
                                      selectedGamePkIndex = index;
                                    });
                                  }
                                }
                                if(selectedGamePkIndex!=null){
                                  AccountRequests.putGame(
                                    gamePk: gameSelectionModel!.dataList[selectedGamePkIndex!].gameId,
                                    callBackGameAdded: ((){
                                      widget.callBackSelectedGame();
                                      Navigator.pop(context);
                                    }),
                                    callBackError: ((error){
                                      print("Error adding game to pro player Error: $error");
                                    }),
                                    gameName: gameSelectionModel!.dataList[selectedGamePkIndex!].gameName,
                                  );
                                }else{
                                  noGamePk = true;
                                }
                              }),
                              label: "Save",
                              icon: Icons.save,
                              radius: Dimensions.marketPlaceProfileButtonHeight/4,
                              color: AppColors.good,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),

        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    _firstLoad();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose;
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ButtonMarketPlace(
      onPressed: ((){
        addGameDialogBuilder(context);
      }),
      label: widget.label,
      radius: widget.radius,
      color: widget.color,
      icon: widget.icon,
    );
  }
}
