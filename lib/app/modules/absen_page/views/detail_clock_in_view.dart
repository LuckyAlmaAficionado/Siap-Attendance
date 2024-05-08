import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:talenta_app/app/controllers/authentication_controller.dart';

import 'package:talenta_app/app/models/user_absensi.dart';
import 'package:talenta_app/app/shared/theme.dart';

// ignore: must_be_immutable
class DetailClockInView extends GetView {
  DetailClockInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract UserAbsensi instance from Get.arguments, handling possible null value
    UserAbsensi? absen = Get.arguments.value as UserAbsensi?;
    final authC = Get.find<AuthenticationController>();

    if (absen == null) {
      // If absen is null, handle gracefully (e.g., show error message)
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error: UserAbsensi data not available'),
        ),
      );
    }

    print('${absen.urlImage}');
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
                                    border: Border.all(
                                      width: 2,
                                      color: darkBlueColor,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        "https://yt3.ggpht.com/ERDsampD88U7cvmuqz1jXcpxIqiekRxIUIcf09z9h1riUdlIu_-E43SkLcB6fzWRj9oGg3oM=s108-c-k-c0x00ffffff-no-rj",
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
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
                      child: Image.network(
                        headers: {"Authorization": "Bearer ${authC.token}"},
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : Center(child: CircularProgressIndicator()),
                        "https://backend-siap-production.up.railway.app/api/v1/absensi/${absen.urlImage}",
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
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

  ListTile _buildListTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: darkGreyTextStyle,
      ),
      subtitle: Text(
        subtitle,
        style: blackTextStyle,
      ),
    );
  }
}
