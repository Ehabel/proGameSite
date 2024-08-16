import 'dart:io';
import 'dart:typed_data';
import 'package:charles_warburton/Account/widget/edit_enum.dart';
import 'package:charles_warburton/Account/widget/requests/account_requests.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
enum Position {
  start,
  middle,
  end,
}
class ListPosition {
  static const Position start = Position.start;
  static const Position middle = Position.middle;
  static const Position end = Position.end;
}

typedef ImageCallBack = void Function(Uint8List);
typedef VoidCallBack = void Function();

class GameImage extends StatefulWidget {
  late Position position;
  late Uint8List? image;
  final ImageCallBack callBackImage;
  final VoidCallBack callBackRemoveImage;
  late EditProfileType editProfileType;
  GameImage({Key? key,
    required this.position,
    required this.image,
    required this.callBackImage,
    required this.callBackRemoveImage,
    required this.editProfileType,
  }) : super(key: key);

  @override
  State<GameImage> createState() => _GameImageState();
}

class _GameImageState extends State<GameImage> {
  final ImagePicker picker = ImagePicker();

  Future addImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    final Uint8List tempImage = await img!.readAsBytes();
    setState(() {
      widget.image = tempImage;
    });
    widget.callBackImage(tempImage);
  }

  void _removeImage(){
    setState(() {
      widget.image = null;
    });
    widget.callBackRemoveImage();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.position==ListPosition.start?
      EdgeInsets.only(
        left: Dimensions.paddingLeft/2,
        right: Dimensions.paddingRight/4,
      ):
      EdgeInsets.only(
        right: widget.position==Position.middle?Dimensions.paddingRight/4:Dimensions.paddingRight/2,
      ),
      height: Dimensions.accountImage,
      width: Dimensions.accountImage,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            margin: EdgeInsets.all(Dimensions.icon30/5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSecondary),
              child: widget.image!=null ?
              Image.memory(
                widget.image!,
                fit: BoxFit.cover,
              )
                  :
              GestureDetector(
                onTap: ((){
                  addImage(ImageSource.gallery);
                }),
                child: Container(
                  height: Dimensions.accountImage,
                  width: Dimensions.accountImage,
                  color: AppColors.backGroundDark,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: Dimensions.icon35,
                    color: AppColors.bottomNavigationButtonColor,
                  ),
                ),
              )
            ),
          ),
          (widget.image != null) && widget.editProfileType == EditProfileType.editMode?
          Container(
            alignment: Alignment.center,
            height: Dimensions.icon30,
            width: Dimensions.icon30,
            decoration: BoxDecoration(
                color: AppColors.buttonSplash,
                borderRadius: BorderRadius.circular(Dimensions.icon30/2)
            ),
            child: FloatingActionButton(
              backgroundColor: AppColors.buttonSplash,
              splashColor: AppColors.buttonSplash,
              onPressed: _removeImage,
              child: Icon(
                  Icons.close_rounded,
                size: Dimensions.icon24,
                color: AppColors.bad,
              ),
            ),
          )
              :
          Container(),
        ],
      ),
    );
  }
}
