import 'package:charles_warburton/Cart/requests/cart_requests.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_sub_heading.dart';
import 'package:charles_warburton/utils/colors.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:charles_warburton/utils/images.dart';
import 'package:flutter/material.dart';
import '../../Account/widget/button_account.dart';
import '../../Cart/models/cart_model.dart';
import 'text_notification_body.dart';

enum NotificationType {
  userWaitingForConfirmation,
  userProDeclinedGame,
  userGameProcessing,
  userGameFinished,
  proPlayerWaitingForConfirmation,
  proPlayerGameProcessing,
  proPlayerGameFinished,
  proPlayerGameDeclined,
}

class Notify {
  static const NotificationType userWaitingForConfirmation = NotificationType.userWaitingForConfirmation;
  static const NotificationType userProDeclinedGame = NotificationType.userProDeclinedGame;
  static const NotificationType userGameProcessing = NotificationType.userGameProcessing;
  static const NotificationType userGameFinished = NotificationType.userGameFinished;
  static const NotificationType proPlayerWaitingForConfirmation = NotificationType.proPlayerWaitingForConfirmation;
  static const NotificationType proPlayerGameProcessing = NotificationType.proPlayerGameProcessing;
  static const NotificationType proPlayerGameFinished = NotificationType.proPlayerGameFinished;
  static const NotificationType proPlayerGameDeclined = NotificationType.proPlayerGameDeclined;
}


class PlayerNotification extends StatefulWidget {
  final int notificationPk;
  final NotificationType notificationType;
  late CartUser cart;
  // late Future<void> firstLoad;

  PlayerNotification({Key? key,
    required this.notificationPk,
    required this.notificationType,
    required this.cart,
    // required firstLoad
  }) : super(key: key);

  @override
  State<PlayerNotification> createState() => _PlayerNotificationState();
}

class _PlayerNotificationState extends State<PlayerNotification> {
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
            children: [
              Container(
                padding: Dimensions.edgeInsetsAllSmall,
                child: const TextNotificationHeading(text: "Notifications"),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backGroundDarkLight,
            borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
          ),
          margin: EdgeInsets.only(
            right: Dimensions.paddingRight/2,
            left: Dimensions.paddingLeft/2,
            bottom: Dimensions.paddingBottom/2,
          ),
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
                margin: Dimensions.edgeInsetsAllSmall,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: Dimensions.paddingBottom/4,
                      ),
                      child: TextNotificationHeading(text: widget.cart.user!.email!),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextNotificationSubHeading(text: "Price:"),
                        TextNotificationBody(text: r'$'+ "${widget.cart!.amount!}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextNotificationSubHeading(text: "Hours:"),
                        TextNotificationBody(text: "${widget.cart!.quantity}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextNotificationSubHeading(text: "Date:"),
                        TextNotificationBody(text: formatDate(widget.cart.orderDate!)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextNotificationSubHeading(text: "Time:"),
                        TextNotificationBody(text: "6:00pm"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextNotificationSubHeading(text: "Order status:"),
                        TextNotificationBody(text: widget.cart.status!),
                      ],
                    ),
                  ],
                ),
              ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.paddingLeft/2,
            right: Dimensions.paddingRight/2,
            bottom: Dimensions.paddingBottom/2,
          ),
          child: widget.cart.status != "ACCEPTED" ? Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: Dimensions.paddingRight/4,
                  ),
                  child: ButtonAccount(
                    onPressed: (() {
                      CartRequests.deleteOrder(widget.cart.orderId!);
                      // widget.firstLoad;
                    }),
                    label: 'Decline',
                    radius: Dimensions.accountButtonHeight/4,
                    color: AppColors.bad,
                    icon: Icons.cancel_rounded,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.paddingLeft/4,
                  ),
                  child: ButtonAccount(
                    onPressed: (() {
                      CartRequests.acceptOrder(widget.cart.orderId!);
                      // widget.firstLoad;
                    }),
                    label: 'Accept',
                    radius: Dimensions.accountButtonHeight/4,
                    color: AppColors.good,
                    icon: Icons.check_circle_rounded,
                  ),
                ),
              ),
            ],
          ) :  TextNotificationSubHeading(text: "Order completed!"),
        ),
      ],
    );
  }
}

String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String formattedDate = "${date.day}/${date.month}/${date.year}";
  return formattedDate;
}

// Widget getNotificationType(NotificationType notify) {
//   if(notify == NotificationType.userWaitingForConfirmation){
//     return UserWaitingForConfirmation();
//   }
//   else if(notify == NotificationType.userProDeclinedGame){
//     return UserProDeclinedGame();
//   }
//   else if(notify == NotificationType.userGameFinished){
//     return UserGameFinished();
//   }
//   else if(notify == NotificationType.userGameProcessing){
//     return UserGameProcessing();
//   }
// }
