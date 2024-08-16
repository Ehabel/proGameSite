import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Cart/models/cart_model.dart';
import '../Cart/requests/cart_requests.dart';
import '../DashBoard/dashboard.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import 'widget/notification.dart';

typedef BoolValue = Function(bool);

class Notifications extends StatefulWidget {
  final BoolValue callBackHideTopBar;
  const Notifications({Key? key,
    required this.callBackHideTopBar,
  }) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}
class _NotificationsState extends State<Notifications> {
  late ScrollController _scrollController;
  late PageController _pageController;
  late int activePage = 0;

  CartModel? _cartModel;

  Future<void> _firstLoad() async {
    await GetCartPro(
      callBackCart: (cartModel) {
        setState(() {
          _cartModel = cartModel;
        });
      },
      callBackError: (statusCode) {
        print("Error: $statusCode");
      },
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      activePage = 0;
    });
    _scrollController = ScrollController();
    _pageController = PageController(initialPage: activePage, viewportFraction: AppConstants.viewPortFractionGameSlider);
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
        child: RawScrollbar(
          padding: EdgeInsets.only(
            right: Dimensions.paddingRight/2-(Dimensions.scrollBarThickness/2),
            top: MediaQuery.of(context).padding.top + Dimensions.paddingTop,
            bottom: getScreenWidth()==ScreenSize.large?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:Dimensions.paddingBottom/2+Dimensions.paddingBottom+Dimensions.bottomBarHeight+MediaQueryData.fromWindow(window).padding.bottom,
          ),
          radius: Radius.circular(Dimensions.scrollBarThickness/4),
          thickness: Dimensions.scrollBarThickness,
          thumbColor: AppColors.scrollBar,
          controller: _scrollController,
          child: RefreshIndicator(
            edgeOffset: MediaQuery.of(context).padding.top,
            onRefresh: _firstLoad,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount:  _cartModel == null ? 1 : _cartModel!.dataList.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return  Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: AppColors.backGroundDarkLight,
                                boxShadow: [AppConstants.shadow],
                                borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                              ),
                              constraints: const BoxConstraints(
                                maxWidth: AppConstants.maxWidth,
                              ),
                              margin: EdgeInsets.only(
                                left: getScreenWidth()==ScreenSize.large?Dimensions.paddingLeft*2+Dimensions.bottomBarHeight:Dimensions.paddingLeft,
                                right: Dimensions.paddingRight,
                                top: Dimensions.paddingTop,
                                bottom: getScreenWidth()==ScreenSize.large && index==20-1?Dimensions.paddingBottom+MediaQueryData.fromWindow(window).padding.bottom:index==20-1? Dimensions.paddingBottom/2+Dimensions.paddingBottom+Dimensions.bottomBarHeight:0,
                              ),
                              child: _cartModel == null ? const TextNotificationHeading(text: "No notifications") : PlayerNotification(
                                notificationPk: _cartModel!.dataList[index].orderId!,
                                notificationType: NotificationType.proPlayerGameFinished,
                                cart: _cartModel!.dataList[index],
                              )
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
