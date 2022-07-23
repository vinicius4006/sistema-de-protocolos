import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TypesWarning {
  showDanger(BuildContext context, String title, String description) {
    return ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger, title: title, text: description));
  }

  showWarning(
    BuildContext context,
    String title,
    String description,
  ) {
    return ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning, title: title, text: description));
  }

  showLoading(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
                size: 80,
                color: Colors.orange,
                secondRingColor: Colors.green,
                thirdRingColor: Colors.indigo),
          );
        });
  }
}
