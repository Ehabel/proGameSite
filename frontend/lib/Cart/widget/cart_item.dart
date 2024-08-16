import 'package:charles_warburton/Cart/requests/cart_requests.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_sub_heading.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:charles_warburton/utils/images.dart';
import 'package:flutter/material.dart';

import '../../Account/widget/button_account.dart';
import '../../Account/widget/star_display_rating.dart';
import '../../Account/widget/text_star_rating.dart';
import '../../Notifications/widget/text_notification_body.dart';
import '../../utils/constants.dart';
import '../cart.dart';
import '../models/cart_model.dart';

class CartItem extends StatefulWidget {
  final int cartItemPk;
  late CartUser cart;
  // late Future<void> Function()? firstLoad;

  CartItem({Key? key,
    required this.cartItemPk, required this.cart,
    // required firstLoad
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.backGroundDarkLight,
            borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
          ),
          margin: Dimensions.edgeInsetsAllSmall,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: Dimensions.paddingTop/2,
                  bottom: Dimensions.paddingBottom/2,
                  left: Dimensions.paddingLeft/2,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                  child: Image.asset(
                    AppImages.pro,
                    height: Dimensions.accountImage,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: Dimensions.accountImage,
                  margin: Dimensions.edgeInsetsAllSmall,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: Dimensions.paddingBottom/4,
                        ),
                        child: TextNotificationHeading(text: widget.cart!.proUser!.email!),
                      ),
                      Row(
                        children: [
                          TextStarRating(text: widget.cart.proUser!.rating == null ? "No rating" : widget.cart!.proUser!.rating!.toString(),),
                          Expanded(child: Container(),),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: Dimensions.paddingBottom/8,
                        ),
                        child: TextNotificationHeading(text: widget.cart!.status!),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextNotificationSubHeading(text: r"AUD "),
                              TextNotificationSubHeading(text: r"$"+"60.00"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        widget.cart!.status! == "ACCEPTED" ? TextNotificationSubHeading(text: "Order completed!") : Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
            left: Dimensions.paddingLeft/2,
            right: Dimensions.paddingRight/2,
            bottom: Dimensions.paddingBottom/2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                child: Container(
                  height: Dimensions.icon30,
                  width: Dimensions.icon30,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.icon30/4),
                    ),
                    onPressed: (() {
                      CartRequests.deleteOrder(widget.cart.orderId!);
                      // widget.firstLoad!;
                    }),
                    backgroundColor: Colors.white,
                    splashColor: AppConstants.splashColor,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.delete_forever,
                        size: Dimensions.icon20,
                        color: Colors.red,
                      ),
                    )
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: Dimensions.icon30,
                    width: Dimensions.icon30,
                    child: IconButton(
                      splashRadius: Dimensions.icon30,
                      padding: EdgeInsets.zero,
                      color: Colors.red,
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.remove,
                        size: Dimensions.icon30,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Dimensions.icon30,
                    decoration: BoxDecoration(
                      color: AppColors.backGroundDark,
                      borderRadius: BorderRadius.circular(Dimensions.icon30/4),
                    ),
                    padding: EdgeInsets.only(
                      left: Dimensions.paddingLeft/2,
                      right: Dimensions.paddingRight/2,
                    ),
                    margin: EdgeInsets.only(
                      left: Dimensions.paddingLeft/2,
                      right: Dimensions.paddingRight/2,
                    ),
                    child: TextNotificationSubHeading(text: "2H",),
                  ),
                  SizedBox(
                    height: Dimensions.icon30,
                    width: Dimensions.icon30,
                    child: IconButton(
                      splashRadius: Dimensions.icon30,
                      padding: EdgeInsets.zero,
                      color: Colors.red,
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.add,
                        size: Dimensions.icon30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}