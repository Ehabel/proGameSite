import 'dart:ui';
import 'package:charles_warburton/DashBoard/models/token_storage.dart';
import 'package:charles_warburton/DashBoard/widget/bottom_navigation_button.dart';
import 'package:charles_warburton/DashBoard/widget/create_game_modal.dart';
import 'package:charles_warburton/DashBoard/widget/hottest_games.dart';
import 'package:charles_warburton/DashBoard/widget/signin_modal.dart';
import 'package:charles_warburton/DashBoard/widget/signout_modal.dart';
import 'package:charles_warburton/DashBoard/widget/signup_modal.dart';
import 'package:charles_warburton/MarketPlace/marketplace.dart';
import 'package:charles_warburton/Notifications/Notifications.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'package:charles_warburton/utils/constants.dart';
import 'package:charles_warburton/utils/images.dart';
import 'package:flutter/material.dart';
import '../Account/account.dart';
import '../Cart/cart.dart';
import '../utils/dimensions.dart';
enum ScreenSizeType {
  small,
  medium,
  large,
}

class ScreenSize {
  static const ScreenSizeType small = ScreenSizeType.small;
  static const ScreenSizeType medium = ScreenSizeType.medium;
  static const ScreenSizeType large = ScreenSizeType.large;
}

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}
class _DashBoardState extends State<DashBoard> {
  late Future<void> Function()? accountFirstLoad;
  late bool _hideTopBar = false;
  late bool isSignedIn;
  late List<bool> selections;

  Future<void> _firstLoad() async {
    String? email = await TokenStorage().extractEmail();
    if(email == null){
      setState(() {
        isSignedIn = false;
      });
    }else{
      setState(() {
        isSignedIn = true;
      });
    }
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selections = [true,false,false,false];
    });
    _firstLoad();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundDark,
      extendBodyBehindAppBar: false,
      drawerEnableOpenDragGesture: true,
      endDrawer: Drawer(
        backgroundColor: AppColors.highLight,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: Dimensions.paddingLeft/2,
              ),
              height: Dimensions.appBarHeight,
              child: const Text(
                "/menu",
                style: TextStyle(
                  inherit: true,
                  fontWeight: AppConstants.fontWeightHeading,
                  fontFamily: AppConstants.fontMain,
                  color: AppColors.fontDark,
                ),
              ),
            ),
            FloatingActionButton(
              hoverColor: AppConstants.hoverColor,
              backgroundColor: AppColors.highLight,
              splashColor: AppConstants.splashColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
              ),
              onPressed: ((){}),
              child: const ListTile(
                leading: Icon(
                  Icons.alternate_email,
                  color: AppColors.fontDark,
                ),
                title: Text(
                  "Contact",
                  style: TextStyle(
                    fontFamily: AppConstants.fontMain,
                    color: AppColors.fontDark,
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              hoverColor: AppConstants.hoverColor,
              backgroundColor: AppColors.highLight,
              splashColor: AppConstants.splashColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
              ),
              onPressed: ((){}),
              child:  const ListTile(
                leading: Icon(
                  Icons.gavel_rounded,
                  color: AppColors.fontDark,
                ),
                title: Text(
                  "Legal",
                  style: TextStyle(
                    color:AppColors.fontDark,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.paddingTop,
              ),
              child: CreateGameButton(
                callBackGameCreated: (() {
                  _firstLoad();
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.paddingTop,
              ),
              child: const PopularGames(),
            ),
            !isSignedIn ? Container(
              margin: EdgeInsets.only(
                top: Dimensions.paddingTop,
              ),
              child: SignUpButton(
                callBackSignUp: (() {
                  if(accountFirstLoad != null){
                    accountFirstLoad!();
                  }
                }),
              ),
            ) : Container(),
            !isSignedIn ? SignInButton(
              callBackSignin: (() {
                if(accountFirstLoad != null) {
                  accountFirstLoad!();
                  setState(() {
                    isSignedIn = true;
                  });
                  _redirectToHomePage(context);
                }}),
            ) : Container(),
            isSignedIn ? SignOutButton(
              callBackSignOut: (() async {
                await TokenStorage().deleteTokenAndEmail();
                accountFirstLoad!();
                setState(() {
                  isSignedIn = false;
                  _redirectToHomePage(context);
                }, );
              }),
            ) : Container(),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,Dimensions.appBarHeight,
        ),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: AppColors.highLight,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimensions.appBarRadius),
              bottomRight: Radius.circular(Dimensions.appBarRadius),
            )
          ),
          height: _hideTopBar?MediaQuery.of(context).padding.top: Dimensions.appBarHeight+MediaQuery.of(context).padding.top,
          duration:  const Duration(
              milliseconds: AppConstants.topBarDuration
          ),
          clipBehavior: Clip.antiAlias,
          child: AppBar(
              toolbarHeight: Dimensions.appBarHeight,
              leadingWidth: 0,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.highLight,
              elevation: 0,
              actions: [
                Builder(
                  builder: (context) =>
                      Container(
                        width: Dimensions.appBarHeight,
                        child: FloatingActionButton(
                          hoverColor: AppConstants.hoverColor,
                          backgroundColor: Colors.transparent,
                          splashColor: AppConstants.splashColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(Dimensions.appBarRadius),
                                bottomRight: Radius.circular(Dimensions.appBarRadius),
                              )
                          ),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                          child: _hideTopBar?Container():const Icon(Icons.menu, color: AppColors.fontDark,),
                        ),
                      ),
                ),
              ],
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title:
              _hideTopBar?
              Container()
                  :
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      AppImages.logo,
                      height: Dimensions.appBarLogoHeight,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: Dimensions.paddingLeft/4,
                      top: Dimensions.paddingTop/2,
                      bottom: Dimensions.paddingTop/3,
                    ),
                    child: Text(
                      AppConstants.name,
                      style: TextStyle(
                        fontFamily: AppConstants.fontLogo,
                        fontWeight: AppConstants.fontWeightLogo,
                        fontSize: Dimensions.font20,
                      ),
                    ),
                  ),
                ],
              )
            // titleTextStyle: const TextStyle(
            //   inherit: true,
            //   color: AppColors.fontDark,
            // ),
          ),
        ),
      ),
      body: Stack(
        alignment: getScreenWidth()==ScreenSize.large?Alignment.topLeft:Alignment.bottomCenter,
        children: [
          getBody(),
          Container(
            // height: Dimensions.bottomBarHeight,
            // width: getScreenWidth()==ScreenSize.large?Dimensions.bottomBarHeight*2:MediaQuery.of(context).size.width-(Dimensions.paddingLeft+Dimensions.paddingRight),
            margin: EdgeInsets.only(
              left: Dimensions.paddingLeft,
              right: Dimensions.paddingRight,
              top: Dimensions.paddingTop+MediaQuery.of(context).padding.top,
              bottom: getScreenWidth()==ScreenSize.large?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:Dimensions.paddingBottom/2+MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getScreenWidth()==ScreenSize.large?Dimensions.bottomBarHeight/4:Dimensions.bottomBarHeight/2),
              color: AppColors.bottomNavigationBarColor,
            ),
            child: Container(
              padding: EdgeInsets.all(Dimensions.navigationButtonPadding),
              child: Flex(
                direction: getScreenWidth()==ScreenSize.large?Axis.vertical:Axis.horizontal,
                children: [
                  Expanded(
                    child: BottomNavigationButton(
                      label: "Market",
                      icon: Icons.store_rounded,
                      index: 0,
                      selections: selections,
                      callBackSelections: ((index){
                        setState(() {
                          for (int i = 0; i < selections.length; i++) {
                            selections[i] = false;
                          }
                          selections[index]=true;
                        });
                      }),
                      borderRadius: getScreenWidth()==ScreenSize.large?
                      BorderRadius.only(
                        topLeft: Radius.circular(getScreenWidth()==ScreenSize.large?Dimensions.bottomBarHeight/4:Dimensions.bottomBarHeight/2),
                        topRight: Radius.circular(getScreenWidth()==ScreenSize.large?Dimensions.bottomBarHeight/4:Dimensions.bottomBarHeight/2),
                      )
                          :
                      BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.bottomBarHeight/2),
                        bottomLeft: Radius.circular(Dimensions.bottomBarHeight/2),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BottomNavigationButton(
                      label: "Account",
                      icon: Icons.account_circle_rounded,
                      index: 1,
                      selections: selections,
                      callBackSelections: ((index){
                        setState(() {
                          for (int i = 0; i < selections.length; i++) {
                            selections[i] = false;
                          }
                          selections[index]=true;
                        });
                      }),
                      borderRadius: const BorderRadius.only(),
                    ),
                  ),
                  Expanded(
                    child: BottomNavigationButton(
                      label: "Pro",
                      icon: Icons.videogame_asset_rounded,
                      index: 2,
                      selections: selections,
                      callBackSelections: ((index){
                        setState(() {
                          for (int i = 0; i < selections.length; i++) {
                            selections[i] = false;
                          }
                          selections[index]=true;
                        });
                      }),
                      borderRadius:  const BorderRadius.only(),
                    ),
                  ),
                  Expanded(
                    child: BottomNavigationButton(
                      label: "Cart",
                      icon: Icons.attach_money_rounded,
                      index: 3,
                      selections: selections,
                      callBackSelections: ((index){
                        setState(() {
                          for (int i = 0; i < selections.length; i++) {
                            selections[i] = false;
                          }
                          selections[index]=true;
                        });
                      }),
                      borderRadius:  getScreenWidth()==ScreenSize.large?
                      BorderRadius.only(
                        bottomLeft: Radius.circular(getScreenWidth()==ScreenSize.large?Dimensions.bottomBarHeight/4:Dimensions.bottomBarHeight/2),
                        bottomRight: Radius.circular(getScreenWidth()==ScreenSize.large?Dimensions.bottomBarHeight/4:Dimensions.bottomBarHeight/2),
                      )
                          :
                      BorderRadius.only(
                        topRight: Radius.circular(Dimensions.bottomBarHeight/2),
                        bottomRight: Radius.circular(Dimensions.bottomBarHeight/2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget getBody() {
    List<Widget> pages = [
      MarketPlace(callBackHideTopBar: ((hideTopBar) {setState(() {
        _hideTopBar = hideTopBar;
      });}),),
      Account(
        callBackHideTopBar: ((hideTopBar) {
          setState(() {
            _hideTopBar = hideTopBar;
          });
        }),
        screenWidth: getScreenWidth(),
        firstLoad: ((firstLoad) async{
          setState(() {
            accountFirstLoad = firstLoad;
          });
        }),
      ),
      Notifications(callBackHideTopBar: ((hideTopBar) {setState(() {
        _hideTopBar = hideTopBar;
      });}),),
      Cart(callBackHideTopBar: ((hideTopBar) {setState(() {
          _hideTopBar = hideTopBar;
        });}),),
    ];
    return IndexedStack(
      index: selections.indexOf(true),
      children: pages,
    );
  }

    void _redirectToHomePage(BuildContext context) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashBoard()),
        );
      });
    }
}
