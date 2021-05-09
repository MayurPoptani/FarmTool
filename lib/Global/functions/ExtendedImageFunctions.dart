import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:extended_image/extended_image.dart';
export 'package:extended_image/extended_image.dart';

Widget extendedImageStateBuilder(ExtendedImageState state) {
  if(state.extendedImageLoadState==LoadState.loading) {
    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green),),);
  } else if(state.extendedImageLoadState==LoadState.completed) {
    return ExtendedRawImage(
      image: state.extendedImageInfo!.image,
      fit: BoxFit.fill,
    );
  } else return Center(child: Text("Faild To \nLoad Image", textAlign: TextAlign.center,),);
}