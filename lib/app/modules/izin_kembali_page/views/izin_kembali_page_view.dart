import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'package:talenta_app/app/controllers/api_controller.dart';
import 'package:talenta_app/app/controllers/model_controller.dart';
import 'package:talenta_app/app/models/model_izin.dart';
import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/button/button_1.dart';
import 'package:talenta_app/app/shared/theme.dart';

import '../controllers/izin_kembali_page_controller.dart';

class IzinKembaliPageView extends GetView<IzinKembaliPageController> {
  IzinKembaliPageView({Key? key}) : super(key: key);

  final homeC = Get.find<HomeController>();
  final m = Get.find<ModelController>();
  final a = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aktivitas Izin", style: appBarTextStyle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: a.fetchPermitByUserId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List<ModelIzin> i = snapshot.data;

                  return ListView.builder(
                    itemCount: i.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      ModelIzin a = i[index];

                      return ListTile(
                        onTap: () => Get.bottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          backgroundColor: whiteColor,
                          PermitActivityDetails(
                            a: a,
                            t: m.u.value.user.id!,
                          ),
                        ),
                        title: Text(
                          (a.status != 0) ? "Izin Masuk" : "Izin Keluar",
                          style: normalTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                            color: (a.status != 0) ? greenColor : redColor,
                          ),
                        ),
                        subtitle: Text(
                          "${DateFormat("dd MMM yyyy", "id_ID").format(a.jamKeluar)}",
                          style: normalTextStyle.copyWith(
                            color: darkGreyColor,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Text(
                          "${a.alasan.isEmpty ? "Note: Tidak ada alasan" : "Note: ${a.alasan.capitalizeFirst}"}",
                          style: normalTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  );
                }

                return Container(
                  child: Center(
                    child: Image.asset("assets/images/img_onboarding1.png"),
                  ),
                );
              },
            ),
          ),
          if (m.ci.value.id != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Button1(
                title: (homeC.isIzin.value) ? "Izin Kembali" : "Izin Keluar",
                onTap: () => Get.toNamed(
                  Routes.LOCATIONS_PAGE,
                  arguments: "argument-izin",
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PermitActivityDetails extends StatelessWidget {
  PermitActivityDetails({super.key, required this.a, required this.t});

  final ModelIzin a;
  final String t;
  final m = Get.find<ModelController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.8,
      width: context.width,
      child: LayoutBuilder(
        builder: (context, constraints) => ListView(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "WAKTU KELUAR",
                style: normalTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
            ),
            Container(
              height: 200,
              width: Get.width,
              child: Row(
                children: [
                  // Map
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: blueColor),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              double.parse(a.latKeluar!),
                              double.parse(a.longKeluar!),
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
                                    double.parse(a.latKeluar!),
                                    double.parse(a.longKeluar!),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: whiteColor),
                                    ),
                                    child: CircleAvatar(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${m.u.value.user.avatar}",
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
                  ),

                  // Gambar Orangnya
                  Expanded(
                    child: Container(
                      width: Get.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          headers: {
                            "Authorization": "Bearer ${m.u.value.token}"
                          },
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : Center(child: CircularProgressIndicator()),
                          "http://192.168.5.9:8080/api/fileSystem/${a.imageKeluar}",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (a.jamMasuk != null) ...{
              Align(
                alignment: Alignment.center,
                child: Text(
                  "WAKTU MASUK",
                  style: normalTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
              ),
              AnimatedContainer(
                height: (a.jamMasuk == null) ? 0 : 200,
                width: context.width,
                duration: const Duration(seconds: 1),
                child: Row(
                  children: [
                    // Map
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: blueColor),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              double.parse(a.latMasuk!),
                              double.parse(a.longMasuk!),
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
                                    double.parse(a.latMasuk!),
                                    double.parse(a.longMasuk!),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: whiteColor),
                                    ),
                                    child: CircleAvatar(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${m.u.value.user.avatar}",
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
                          headers: {
                            "Authorization": "Bearer ${m.u.value.token}"
                          },
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : Center(child: CircularProgressIndicator()),
                          "http://192.168.5.9:8080/api/fileSystem/${a.imageMasuk}",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            },
            _buildListTile(
              "Keterangan Waktu",
              "Waktu Keluar: ${DateFormat("hh:mm").format(a.jamKeluar)}\nWaktu Masuk: ${(a.jamMasuk != null) ? DateFormat("hh:mm").format(a.jamMasuk!) : "Belum Kembali"}",
            ),
            _buildListTile(
              "Position",
              "Latitude: ${a.latKeluar}\nLongitude: ${a.longKeluar}",
            ),
            _buildListTile("Alasan", "${a.alasan}"),
          ],
        ),
      ),
    );
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
