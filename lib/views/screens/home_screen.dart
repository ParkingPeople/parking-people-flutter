import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/translations.dart';
import 'package:parking_people_flutter/utils/extensions/list_utils.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/custom_card.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

import '/utils/extensions/string_utils.dart';

part 'home_screen.g.dart';

bool canClose = false;
Timer timer = Timer(Duration.zero, () {});

late String normalizedAddress;

Position? currentPosition;

@hwidget
Widget homeScreen(BuildContext context) {
  final ValueNotifier<Placemark?> location = useState<Placemark?>(null);

  final ValueNotifier<bool> isLoadingPosition = useValueNotifier<bool>(false);

  final textEditingController = useTextEditingController();

  final focusNode = useFocusNode();

  void gotoNextScreen({
    required String address,
    Position? position,
  }) async {
    if (isLoadingPosition.value) {
      return;
    }
    Location? finalPosition;
    if (address.isNotEmpty) {
      if (position == null) {
        isLoadingPosition.value = true;
        try {
          List<Location> locations = await locationFromAddress(address);
          if (locations.isNotEmpty) {
            defaultLogger.i(locations);
            finalPosition = locations.first;
          }
        } on NoResultFoundException catch (e) {
          defaultLogger.e(e);
        }
      } else {
        finalPosition = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: position.timestamp ?? DateTime.now(),
        );
      }
      if (finalPosition != null) {
        await Navigator.of(context).pushNamed(
          Routes.searchResult,
          arguments: {
            'address': address,
            'location': finalPosition,
          },
        );
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
              Strings.locationNotFound.i18n,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            backgroundColor: Theme.of(context).dialogBackgroundColor,
          ));
      }
      isLoadingPosition.value = false;
    } else {
      focusNode.requestFocus();
    }
  }

  void getLocation() async {
    final Position position = await Geolocator.getCurrentPosition();
    currentPosition = position;
    final Locale appLocale = Localizations.localeOf(context);
    final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: appLocale.languageCode);
    if (placemarks.isNotEmpty) {
      location.value = placemarks.first;
    }
  }

  final int builds = useBuildsCount();
  if (builds == 1) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await Permission.location.isGranted) {
        getLocation();
      } else {
        if (await Permission.location.shouldShowRequestRationale) {
          if (await Permission.location.request().isGranted &&
              await Permission.location.serviceStatus.isEnabled) {
            getLocation();
          }
        } else if (await Permission.location.isPermanentlyDenied) {
          Fluttertoast.showToast(msg: Strings.allowLocationAsk.i18n);
          openAppSettings();
        }
      }
    });
  }

  return WillPopScope(
    onWillPop: () async {
      timer.cancel();
      if (!canClose) {
        timer = Timer(
          const Duration(
            seconds: 2,
          ),
          () {
            canClose = false;
          },
        );
        canClose = true;
        await Fluttertoast.cancel();
        Fluttertoast.showToast(msg: Strings.closeAgain.i18n);
        return false;
      }
      return canClose;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Assets.images.splashTitle.svg(
          color: Theme.of(context).textTheme.bodyText2?.color,
          height: 20,
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).textTheme.bodyText2?.color,
        elevation: 0,
      ),
      endDrawer: Drawer(
        child: Builder(
          builder: (context) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: ColorName.blue,
                  ),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_rounded),
                  title: const Text('Alerts'),
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Alerts item tapped');
                    Scaffold.of(context).closeEndDrawer();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text('Profile'),
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Profile item tapped');
                    Scaffold.of(context).closeEndDrawer();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_rounded),
                  title: const Text('Settings'),
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Settings item tapped');
                    Scaffold.of(context).closeEndDrawer();
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(0),
            CustomCard(
              title: Strings.searchTitle.i18n,
              builder: (context, child) {
                return Column(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: isLoadingPosition,
                      builder: (context, isLoading, child) {
                        return TextField(
                          readOnly: isLoading,
                          controller: textEditingController,
                          focusNode: focusNode,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: Strings.searchHint.i18n,
                            suffixIcon: const Icon(Icons.search_rounded),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (text) {
                            gotoNextScreen(address: text);
                          },
                        );
                      },
                    ),
                    const Gap(32),
                    Row(
                      children: [
                        const Gap(16),
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: isLoadingPosition,
                            builder: (context, isLoading, child) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorName.blue,
                                  primary: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        gotoNextScreen(
                                            address:
                                                textEditingController.text);
                                      },
                                child: isLoading
                                    ? const SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : Text(
                                        Strings.searchAction.i18n,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                        const Gap(16),
                      ],
                    )
                  ],
                );
              },
            ),
            CustomCard(
              title: Strings.recommendHere.i18n,
              onTap: () {
                if (currentPosition != null) {
                  gotoNextScreen(
                      address: normalizedAddress, position: currentPosition);
                }
              },
              child: (() {
                final place = location.value;
                if (place == null) return null;
                final streetAddress =
                    '${place.administrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare} ${place.subThoroughfare}';
                final normalized = streetAddress.toHalfWidth
                    .replaceAll(RegExp(r' +'), ' ')
                    .trim();
                normalizedAddress = normalized;
                return Text(
                  normalized,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                );
              })(),
            ),
            CustomCard(
              title: Strings.takePhotoAction.i18n,
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
          ]
              .wrapEachPadding(const EdgeInsets.symmetric(horizontal: 24))
              .withSpacer(const Gap(16))
              .toList(),
        ),
      ),
    ),
  );
}

@swidget
Widget skeletonText(
  BuildContext context,
  String text, {
  double? fontSize,
}) {
  final defaultTextStyle = Theme.of(context).textTheme.bodyText2;

  final themeFontSize = defaultTextStyle?.fontSize ?? 13;

  final Color textUnderColor = defaultTextStyle?.color ??
      (Theme.of(context).brightness == Brightness.light
          ? ColorName.black
          : Colors.white);

  return Shimmer.fromColors(
    baseColor: textUnderColor.withOpacity(0.6),
    highlightColor: textUnderColor.withOpacity(0.8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: text.length * themeFontSize,
        height: themeFontSize,
        child: const ColoredBox(
          color: Colors.white,
        ),
      ),
    ),
  );
}
