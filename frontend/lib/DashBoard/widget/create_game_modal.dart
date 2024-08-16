import 'dart:io';
import 'dart:typed_data';
import 'package:charles_warburton/Account/widget/edit_enum.dart';
import 'package:charles_warburton/DashBoard/widget/game_images.dart';
import 'package:charles_warburton/Notifications/widget/text_notification_heading.dart';
import 'package:charles_warburton/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../MarketPlace/widget/button.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../requests/dashboard_requests.dart';

typedef VoidValue = void Function();

class CreateGameButton extends StatefulWidget {
  VoidValue callBackGameCreated;
  CreateGameButton({Key? key,
    required this.callBackGameCreated,
  }) : super(key: key);

  @override
  State<CreateGameButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<CreateGameButton> {
  late List<Uint8List?> images = [null, null];
  final GlobalKey<FormState> _formKey = GlobalKey();
  late List<bool> missingImages = [false,false];
  final TextEditingController gameNameController = TextEditingController();
  final TextEditingController gameTagController = TextEditingController();
  final TextEditingController gameDetailsController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose;
    gameNameController.dispose();
    gameTagController.dispose();
    gameDetailsController.dispose();
    super.dispose();
  }
  Future<void> signUpDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
                surfaceTintColor: AppColors.fontDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                ),
                backgroundColor: AppColors.secondaryBackGroundDark,
                title: Container(
                  padding: EdgeInsets.only(top: Dimensions.paddingTop),
                  alignment: Alignment.center,
                  child:  const TextNotificationHeading(text: "Create Game",),
                ),
                content: SingleChildScrollView(
                  child:  Container(
                    width: AppConstants.maxWidth*0.75,
                    margin: Dimensions.edgeInsetsAll,
                    padding: Dimensions.edgeInsetsAll,
                    child: Form(
                        key: _formKey,
                        child:  Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Missing Game Name';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: AppColors.fontDark,
                              ),
                              controller: gameNameController,
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColors.good,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.gamepad_rounded,
                                  color: AppColors.fontDark,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                labelText: 'Game Name',
                                labelStyle: const TextStyle(
                                  color: AppColors.fontDark,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusColor: AppColors.fontDark,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.paddingTop/2,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Missing Tag';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: AppColors.fontDark,
                              ),
                              controller: gameTagController,
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColors.good,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.tag,
                                  color: AppColors.fontDark,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                labelText: 'Tag',
                                labelStyle: const TextStyle(
                                  color: AppColors.fontDark,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusColor: AppColors.fontDark,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.paddingTop/2,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Missing About';
                                }
                                return null;
                              },
                              maxLines: null,
                              style: const TextStyle(
                                color: AppColors.fontDark,
                              ),
                              controller: gameDetailsController,
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColors.good,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.info_rounded,
                                  color: AppColors.fontDark,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
                                    borderSide: const BorderSide(color: AppColors.fontDark)
                                ),
                                labelText: 'About',
                                labelStyle: const TextStyle(
                                  color: AppColors.fontDark,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusColor: AppColors.fontDark,
                              ),
                            ),
                            GameImages(
                              missingImages: missingImages,
                              editProfileType: EditProfile.editMode,
                              images: images,
                              callBackRemoveImageAt: ((index){
                                setState(() {
                                  images[index] = null;
                                });
                              }),
                              callBackImage: ((callBackImage, index){
                                setState(() {
                                  images[index] = callBackImage;
                                });
                              }), title: const ["Dark Image:", "Light Image:"],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.paddingTop
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ButtonMarketPlace(
                                      label: "Cancel",
                                      icon: Icons.cancel_rounded,
                                      radius: Dimensions.radius20,
                                      color: AppColors.highLight,
                                      onPressed: (() {
                                        Navigator.pop(context);
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingLeft/4,
                                  ),
                                  Expanded(
                                    child: ButtonMarketPlace(
                                      label: "Create Game",
                                      icon: Icons.check_circle_rounded,
                                      radius: Dimensions.radius20,
                                      color: AppColors.good,
                                      onPressed: ((){
                                        final form = _formKey.currentState!;
                                        if(form.validate() && images[0]!=null && images[1]!=null){
                                          CreateGame(
                                            name: gameNameController.text,
                                            tag: gameTagController.text,
                                            details: gameDetailsController.text,
                                            imageDark: images[0]!,
                                            imageLight: images[1]!,
                                            callBackGameCreated: () {
                                              widget.callBackGameCreated();
                                              Navigator.pop(context);
                                            },
                                            callBackError: (statusCode) {
                                              print("Error: $statusCode");
                                            },
                                          );
                                        }
                                        if(images[0]==null){
                                          setState(() {
                                            missingImages[0] = true;
                                          });
                                        }else{
                                          setState((){
                                            missingImages[0] = false;
                                          });
                                        }
                                        if(images[1]==null){
                                          setState(() {
                                            missingImages[1] = true;
                                          });
                                        }else{
                                          setState((){
                                            missingImages[1] = false;
                                          });
                                        }
                                      }
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
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
        signUpDialogBuilder(context);
      }),
      child:  const ListTile(
        leading: Icon(
          Icons.gamepad_rounded,
          color: AppColors.fontDark,
        ),
        title: Text(
          "Create Game",
          style: TextStyle(
            color:AppColors.fontDark,
          ),
        ),
      ),
    );
  }
}
