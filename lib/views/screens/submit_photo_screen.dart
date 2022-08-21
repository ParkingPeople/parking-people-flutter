import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';
import 'package:parking_people_flutter/views/components/custom_card.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';
import 'package:path_provider/path_provider.dart';

part 'submit_photo_screen.g.dart';

@swidget
Widget submitPhotoScreen(BuildContext context) {
  return CommonScaffold(
    title: '사진 또는 동영상으로 포인트 얻기',
    children: [
      CustomCard(
        title: '촬영 하기',
        onTap: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? photo = await picker.pickImage(
            source: ImageSource.camera,
            preferredCameraDevice: CameraDevice.rear,
          );
          if (photo != null) {
            final appDocDir = await getApplicationDocumentsDirectory();
            final now = DateTime.now().millisecondsSinceEpoch;
            // final filename = appDocDir.path.endsWith(r'/') ? '$now' : '/$now';
            const filename = 'submitPhoto.jpg';
            submitPhotoPath = appDocDir.path + filename;
            photo.saveTo(submitPhotoPath);

            Navigator.of(context).pushNamed(Routes.photoSubmissionResult);
          }
        },
      ),
    ],
  );
}
