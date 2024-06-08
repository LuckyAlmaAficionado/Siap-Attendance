import 'package:flutter/material.dart';

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:latlong2/latlong.dart';

import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/modules/locations/controllers/locations_page_controller.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/loading_dialog.dart';
import 'package:talenta_app/app/shared/theme.dart';

class LocationsPageView extends StatefulWidget {
  const LocationsPageView({Key? key}) : super(key: key);

  @override
  State<LocationsPageView> createState() => _LocationsPageViewState();
}

class _LocationsPageViewState extends State<LocationsPageView> {
  final controller = Get.put(LocationsPageController());
  final m = Get.find<ModelController>();
  String status = "";

  @override
  void initState() {
    super.initState();
    status = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: context.height * 1,
            child: StreamBuilder<Position>(
              stream: controller.locationStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingDialog(
                      text: "Tunggu Sebentar Yaa...", icon: Icons.abc);
                } else if (snapshot.hasData) {
                  final position = snapshot.data!;

                  return FlutterMap(
                    options: MapOptions(
                      maxZoom: 18,
                      minZoom: 17,
                      keepAlive: false,
                      applyPointerTranslucencyToLayers: true,
                      initialCenter: LatLng(
                        position.latitude,
                        position.longitude,
                      ),
                      initialZoom: 17,
                      interactionOptions: InteractionOptions(
                        enableMultiFingerGestureRace: false,
                        enableScrollWheel: false,
                        debugMultiFingerGestureWinner: false,
                        cursorKeyboardRotationOptions:
                            CursorKeyboardRotationOptions.disabled(),
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        maxZoom: 19,
                      ),

                      CurrentLocationLayer(
                        alignPositionOnUpdate: AlignOnUpdate.always,
                        alignDirectionOnUpdate: AlignOnUpdate.never,
                        style: LocationMarkerStyle(
                          showHeadingSector: false,
                          marker: DefaultLocationMarker(
                            child: m.u.value!.avatar!.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      "${m.u.value!.avatar}",
                                    ),
                                  )
                                : HeroIcon(HeroIcons.user),
                          ),
                          markerSize: const Size(40, 40),
                          markerDirection: MarkerDirection.top,
                        ),
                      ), // <
                    ],
                  );
                } else {
                  return SizedBox(); // Kasus lain, tampilkan widget kosong
                }
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Button1(
                      title: "Lanjutkan Absensi",
                      onTap: () async =>
                          await controller.checkCurrentLocation(status),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Boxicons.bx_arrow_back,
                        color: blackColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: AnimatedRotation(
                      turns: controller.turns.value,
                      duration: const Duration(seconds: 2),
                      child: IconButton(
                        onPressed: () {
                          controller.turns.value -= 5 / 1;
                          setState(() {});
                          setState(() {});
                        },
                        icon: Icon(
                          // Icons.refresh_rounded,
                          Boxicons.bx_refresh,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
