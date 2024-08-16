import 'dart:convert';

import 'package:charles_warburton/Account/widget/account_bio.dart';
import 'package:charles_warburton/Account/widget/account_game_select_button.dart';
import 'package:charles_warburton/Account/widget/account_header.dart';
import 'package:charles_warburton/Account/widget/account_images.dart';
import 'package:charles_warburton/Account/widget/edit_enum.dart';
import 'package:charles_warburton/Account/widget/models/user_model.dart';
import 'package:charles_warburton/Account/widget/requests/account_requests.dart';
import 'package:charles_warburton/Account/widget/signup_button.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../DashBoard/dashboard.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';
import 'widget/signin_button.dart';


typedef BoolValue = Function(bool);
typedef AsyncCallback = Future<void> Function(Future<void> Function());

class Account extends StatefulWidget {
  final BoolValue callBackHideTopBar;
  late ScreenSizeType screenWidth;
  final AsyncCallback firstLoad;
  Account({Key? key,
    required this.callBackHideTopBar,
    required this.screenWidth,
    required this.firstLoad,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();

}
class _AccountState extends State<Account> {
  late bool hasBioTextBeenEdited = false;
  late String bioText = "Update bio text!";
  late EditProfileType editProfileType = EditProfile.normalMode;
  late ScrollController _scrollController;
  late PageController _pageController;
  late int activePage = 0;
  UserModel? _userModel;
  late List<String> images = [];
  Future<void> _firstLoad() async {
    GetUser(
      callBackUser: (userModel) {
        setState(() {
          _userModel = userModel;
          if (_userModel != null && _userModel!.images != null) {
            for (var image in _userModel!.images!) {
              if (image.filename != null) {
                images.add(image.filename!);
              }
            }
          }
        });
      },
      callBackError: (statusCode) {
        print("Error: $statusCode");
      },
    );
  }
  Future<void> _loadMore() async {

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      activePage = 0;
    });
    _firstLoad();
    widget.firstLoad(_firstLoad);
    _scrollController = ScrollController();
    _pageController = PageController(initialPage: activePage, viewportFraction: AppConstants.viewPortFractionGameSlider);

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
        child: RawScrollbar(
          padding: EdgeInsets.only(
            right: Dimensions.paddingRight/2-(Dimensions.scrollBarThickness/2),
            top: MediaQuery.of(context).padding.top + Dimensions.paddingTop,
            bottom: widget.screenWidth==ScreenSize.large?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:Dimensions.paddingBottom/2+Dimensions.paddingBottom+Dimensions.bottomBarHeight,
          ),
          radius: Radius.circular(Dimensions.scrollBarThickness/4),
          thickness: Dimensions.scrollBarThickness,
          thumbColor: AppColors.scrollBar,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: widget.screenWidth==ScreenSizeType.large?Dimensions.bottomBarHeight+Dimensions.paddingLeft:0,
                // left: getScreenWidth()==ScreenSize.large&&index==0?Dimensions.bottomBarHeight+Dimensions.paddingLeft*2:index==0?Dimensions.paddingLeft:Dimensions.paddingLeftGameSlider,
                top: MediaQuery.of(context).padding.top,
                bottom: widget.screenWidth==ScreenSize.large?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:Dimensions.paddingBottom/2+Dimensions.paddingBottom+Dimensions.bottomBarHeight,
              ),
              padding: EdgeInsets.only(
                top: Dimensions.paddingTop,
                left: Dimensions.paddingLeft,
                right: Dimensions.paddingRight,
              ),
              color: AppColors.backGroundDark,
              child: _userModel!=null?
              Column(
                children: [
                  AccountHeader(
                    userName: _userModel!.email!,
                    screenWidth: widget.screenWidth,
                    userRating: _userModel!.rating == null ? 0 : _userModel!.rating!,
                    imageUrl: _userModel!.picture == null ? AppImages.pro : _userModel!.images!.first.filename!,
                    editProfileType: editProfileType,
                    callBackEditProfileType: ((callBackEditProfileType){
                      setState(() {
                        editProfileType = callBackEditProfileType;
                      });
                      if(hasBioTextBeenEdited && callBackEditProfileType==EditProfileType.normalMode){
                        hasBioTextBeenEdited = false;
                        AccountRequests.editBio(bioText).then((responseString) {
                          Map<String, dynamic> data = jsonDecode(responseString);
                          String description = data['description'];
                          bioText = description;
                          setState(() {
                            _userModel!.description = bioText;
                          });
                        }).catchError((error) {
                          print('Error occurred: $error');
                        });
                      }
                    }),
                  ),
                  AccountImages(images: images, editProfileType: editProfileType,),
                  AccountBio(
                    editProfileType: editProfileType,
                    text: _userModel?.description == null ? bioText : _userModel!.description!,
                    callBackText: ((text) {
                      setState(() {
                        hasBioTextBeenEdited = true;
                        bioText = text;
                      });
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height120),
                    constraints: const BoxConstraints(
                      maxWidth: AppConstants.maxWidth,
                    ),
                    width: double.infinity,
                    child: _userModel != null ?
                    _userModel!.pro! == true ? GameSelectButtonAccount(
                      label: 'Select Game',
                      color: AppColors.good,
                      icon: Icons.gamepad_rounded,
                      radius: Dimensions.marketPlaceProfileButtonHeight/4,
                      callBackSelectedGame: (() {
                        _firstLoad();
                      }),
                    ) : Container() : Container(),
                  ),
                ],
              )
                  :
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: AppConstants.maxWidth,
                    ),
                    width: double.infinity,
                    child: _userModel != null ? _userModel!.pro! == true ? GameSelectButtonAccount(
                      label: 'Select Game',
                      color: AppColors.good,
                      icon: Icons.gamepad_rounded,
                      radius: Dimensions.marketPlaceProfileButtonHeight/4,
                      callBackSelectedGame: (() {
                        _firstLoad();
                      }),
                    ) : Container() : Container(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height120),
                    constraints: const BoxConstraints(
                      maxWidth: AppConstants.maxWidth,
                    ),
                    width: double.infinity,
                    child: SignUpButtonAccount(
                      label: 'Create Account',
                      color: AppColors.good,
                      icon: Icons.account_circle_rounded,
                      radius: Dimensions.marketPlaceProfileButtonHeight/4,
                      callBackSignUp: (() {
                        _firstLoad();
                      }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.paddingTop/2),
                    constraints: const BoxConstraints(
                      maxWidth: AppConstants.maxWidth,
                    ),
                    width: double.infinity,
                    child: SignInButtonAccount(
                      label: 'Login',
                      color: AppColors.highLight,
                      icon: Icons.login_rounded,
                      radius: Dimensions.marketPlaceProfileButtonHeight/4,
                      callBackSignin: (() {
                        _firstLoad();
                        _redirectToHomePage(context);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
