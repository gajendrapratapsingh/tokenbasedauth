import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tokenauthapp/utils/constant_colors.dart';


class OthersHelper with ChangeNotifier {
  ConstantColors cc = ConstantColors();
  int deliveryCharge = 60;

  showLoading(Color color) {
    return SpinKitThreeBounce(
      color: color,
      size: 16.0,
    );
  }

  // showError(BuildContext context, String errorText) {
  //   return GetBuilder<AppStringService>(
  //     builder: (ln) => Container(
  //         height: MediaQuery.of(context).size.height - 180,
  //         alignment: Alignment.center,
  //         child: Text(ln.getString(errorText))),
  //   );
  // }

  void showToast(String msg, Color? color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // snackbar
  showSnackBar(BuildContext context, String msg, color) {
    var snackBar = SnackBar(
      content: Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      duration: const Duration(milliseconds: 2000),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void toastShort(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}