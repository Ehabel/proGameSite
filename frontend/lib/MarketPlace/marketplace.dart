import 'package:charles_warburton/MarketPlace/models/gamepro_model.dart';
import 'package:charles_warburton/MarketPlace/requests/game_requests.dart';
import 'package:charles_warburton/MarketPlace/widget/custom_scroll_bar.dart';
import 'package:charles_warburton/MarketPlace/widget/game_selection_widget.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../DashBoard/dashboard.dart';
import '../Notifications/widget/text_notification_heading.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import 'marketplace_pro_profile.dart';

typedef BoolValue = Function(bool);

class MarketPlace extends StatefulWidget {
  final BoolValue callBackHideTopBar;
  const MarketPlace({Key? key,
    required this.callBackHideTopBar,
  }) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}
class _MarketPlaceState extends State<MarketPlace> {
  late ScrollController _scrollController;
  final Key _key = GlobalKey();
  late List<bool> activeGameBanner = [];
  late String activeGame = 'destiny2';
  GameModel? _gameModel;

  Future<void> _firstLoad() async {
    await GetGamePro(
      callBackGamePro: (gameModel) {
        setState(() {
          _gameModel = gameModel;
        });
      },
      callBackError: (statusCode) {
        setState(() {
          _gameModel = null;
        });
      },
      gameName: activeGame,
    );
  }
  Future<void> _loadMore() async {

  }
  ScreenSizeType getScreenWidth(){
    if(MediaQuery.of(context).size.width<=640){
      return ScreenSize.small;
    }else if(640< MediaQuery.of(context).size.width && MediaQuery.of(context).size.width<=1007){
      return ScreenSize.medium;
    }
    else{
      return ScreenSize.large;
    }
  }

  String extractGameName(String path) {
    List<String> parts = path.split('/');
    String fileName = parts[parts.length - 1];
    List<String> nameParts = fileName.split('-');
    String gameName = nameParts[0];
    return gameName;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      activeGameBanner = List.generate(AppImages.gameLogosSelected.length, (index) => index==0?true:false);
    });
    _scrollController = ScrollController();
    _firstLoad();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ((){
        FocusManager.instance.primaryFocus?.unfocus();
      }),
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification){
          if(_scrollController.position.userScrollDirection==ScrollDirection.forward){
            setState(() {
              widget.callBackHideTopBar(false);
            });
          }else if(_scrollController.position.userScrollDirection==ScrollDirection.reverse){
            setState(() {
              widget.callBackHideTopBar(true);
            });
          }
          if(scrollNotification.metrics.maxScrollExtent*0.6 <= scrollNotification.metrics.pixels){
            _loadMore();
          }
          return true;
        },
        child: CustomScrollBar(
          padding: EdgeInsets.only(
            right: Dimensions.paddingRight/2-(Dimensions.scrollBarThickness/2),
            top: MediaQuery.of(context).padding.top + Dimensions.paddingTop,
            bottom: getScreenWidth()==ScreenSize.large?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:Dimensions.paddingBottom/2+Dimensions.paddingBottom+Dimensions.bottomBarHeight+MediaQueryData.fromWindow(window).padding.bottom,
          ),
          scrollController: _scrollController,
          child: RefreshIndicator(
            edgeOffset: MediaQuery.of(context).padding.top,
            onRefresh: _firstLoad,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: _gameModel == null || _gameModel!.users!.isEmpty ? 1 : _gameModel!.users!.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return index==0?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: Dimensions.paddingTop-Dimensions.height20,
                            ),
                            height: Dimensions.gameSelectionImageHeightSelected+Dimensions.height20,
                            width: MediaQueryData.fromView(window).size.width,
                            child: ListView.builder(
                              key: _key,
                              scrollDirection: Axis.horizontal,
                              itemCount: AppImages.gameLogosSelected.length,
                              itemBuilder: ((BuildContext context, int index) {
                                return AnimatedContainer(
                                  alignment: Alignment.center,
                                  duration: const Duration(milliseconds: AppConstants.buttonIconDuration),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: Dimensions.height10,
                                      bottom: Dimensions.height10,
                                    ),
                                    decoration: BoxDecoration(
                                        boxShadow: [AppConstants.shadow]
                                    ),
                                    alignment: Alignment.center,
                                    height: activeGameBanner[index]? Dimensions.gameSelectionImageHeightSelected: Dimensions.gameSelectionImageHeight,
                                    width: Dimensions.gameSelectionImageWidth,
                                    margin: EdgeInsets.only(
                                      left: getScreenWidth()==ScreenSize.large&&index==0?Dimensions.bottomBarHeight+Dimensions.paddingLeft*2:index==0?Dimensions.paddingLeft:Dimensions.paddingLeftGameSlider,
                                      right: index==AppImages.gameLogosSelected.length-1?Dimensions.paddingRight:Dimensions.paddingLeftGameSlider,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                      child: GameSelectionImage(
                                        isSelected: activeGameBanner[index],
                                        image: AppImages.gameLogosSelected[index],
                                        imageIsSelected: AppImages.imagesIsSelected[index],
                                        onPressed: ((){
                                          setState(() {
                                            activeGameBanner = List.generate(AppImages.gameLogosSelected.length, (indx) => indx==index?true:false);
                                            activeGameBanner[index] = true;
                                            activeGame = extractGameName(AppImages.imagesIsSelected[index]);
                                          });
                                          _firstLoad();
                                        }),
                                      ),
                                    )
                                  ),
                                );
                              }),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [AppConstants.shadow]
                            ),
                            margin: EdgeInsets.only(
                              left: getScreenWidth()==ScreenSize.large?Dimensions.paddingLeft*2+Dimensions.bottomBarHeight:Dimensions.paddingLeft,
                              right: Dimensions.paddingRight,
                              top: Dimensions.paddingTop-Dimensions.height20,
                              bottom: getScreenWidth()==ScreenSize.large && index==20-1?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:index==20-1? Dimensions.paddingBottom/2+Dimensions.paddingBottom+Dimensions.bottomBarHeight:0,
                            ),
                            child: _gameModel == null || _gameModel!.users!.isEmpty ? const TextNotificationHeading(text: "No pros") : MarketPlaceProfile(user: _gameModel!.users!.first),
                          ),
                        ],
                      )
                          :
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [AppConstants.shadow]
                            ),
                            margin: EdgeInsets.only(
                              left: getScreenWidth()==ScreenSize.large?Dimensions.paddingLeft*2+Dimensions.bottomBarHeight:Dimensions.paddingLeft,
                              right: Dimensions.paddingRight,
                              top: Dimensions.paddingTop,
                              bottom: getScreenWidth()==ScreenSize.large && index==20-1?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:index==20-1? Dimensions.paddingBottom/2+Dimensions.paddingBottom+Dimensions.bottomBarHeight:0,
                            ),
                            child: _gameModel == null ? const TextNotificationHeading(text: "No pros") : MarketPlaceProfile(user: _gameModel!.users![index]),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
