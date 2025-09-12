import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingWidget() {
  return Center(
    child: SpinKitFadingFour(
      color: Colors.white,    
      size: 30.0,              
    ),
  );
}