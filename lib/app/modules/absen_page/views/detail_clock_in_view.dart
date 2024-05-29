import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/shared/images/images.dart';
import 'package:talenta_app/app/shared/theme.dart';

// ignore: must_be_immutable
class DetailClockInView extends GetView {
  DetailClockInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ModelAbsensi? absen = Get.arguments as ModelAbsensi?;
    final ModelController m = Get.find<ModelController>();
    final ApiController a = Get.put(ApiController());

    if (absen == null) {
      // If absen is null, handle gracefully (e.g., show error message)
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error: ModelAbsensi data not available'),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail ${absen.type}',
            style: appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              width: Get.width,
              child: Row(
                children: [
                  // Map
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: blueColor),
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(
                            double.parse(absen.lat!),
                            double.parse(absen.lang!),
                          ),
                          initialZoom: 17,
                          maxZoom: 18,
                          minZoom: 17,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                            maxZoom: 19,
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 45.0,
                                height: 45.0,
                                point: LatLng(
                                  double.parse(absen.lat!),
                                  double.parse(absen.lang!),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 2, color: whiteColor),
                                  ),
                                  child: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: ImageNetwork(
                                        url: m.u.value!.avatar!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Gambar Orangnya
                  Expanded(
                    child: Container(
                      width: Get.width,
                      child: ImageNetwork(
                          borderRadius: 0,
                          boxFit: BoxFit.fitWidth,
                          url: "${a.BASE_URL}/api/fileSystem/${absen.image}"),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                children: [
                  _buildListTile(
                      'Waktu ${absen.type}',
                      DateFormat("HH:mm - (dd MMM yyyy)", "id_ID")
                          .format(absen.createdAt!)),
                  const Divider(),
                  _buildListTile('Shift', 'Office2 (08:00 - 16:45)'),
                  const Divider(),
                  _buildListTile(
                      'Jadwal Shift',
                      DateFormat("EEE, dd MMM yyyy", "id_ID")
                          .format(DateTime.now())),
                  const Divider(),
                  _buildListTile('Lokasi', absen.address!),
                  const Divider(),
                  _buildListTile('Koordinat', '${absen.lat}, ${absen.lang}'),
                  const Divider(),
                  _buildListTile('Catatan', absen.catatan!),
                ],
              ),
            ),
          ],
        ));
  }

  ListTile _buildListTile(String title, String subtitle) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Text(
          title,
          style: normalTextStyle.copyWith(color: darkGreyColor),
        ),
        subtitle: Text(subtitle, style: normalTextStyle),
      );
}
