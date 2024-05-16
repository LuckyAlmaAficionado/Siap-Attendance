import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:talenta_app/app/models/karyawan.dart';
import 'package:talenta_app/app/modules/dashboard_page/controllers/dashboard_page_controller.dart';
import 'package:talenta_app/app/routes/app_pages.dart';
import 'package:talenta_app/app/shared/theme.dart';

// ignore: must_be_immutable
class KaryawanPageView extends StatefulWidget {
  KaryawanPageView({super.key});
  bool isVisible = false;

  @override
  State<KaryawanPageView> createState() => _KaryawanPageViewState();
}

class _KaryawanPageViewState extends State<KaryawanPageView> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchC = TextEditingController();
  final controller = Get.put(DashboardPageController());

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (widget.isVisible != true) {
          setState(() {
            widget.isVisible = true;
          });
        }
      } else {
        if (widget.isVisible != false) {
          setState(() {
            widget.isVisible = false;
          });
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (widget.isVisible != false) {
          setState(() {
            widget.isVisible = false;
          });
        }
      } else {
        if (widget.isVisible != true) {
          setState(() {
            widget.isVisible = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Karyawan',
          style: appBarTextStyle,
        ),
        backgroundColor: blueColor,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            height: 45,
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: searchC,
              onChanged: (value) {
                if (value.length == 0) {
                  controller.sortingKaryawan.clear();
                } else {
                  controller.sortingKaryawan(controller.karyawan
                      .where((element) =>
                          element.name![0].toLowerCase() ==
                          value[0].toLowerCase())
                      .where((element) =>
                          element.name!
                              .substring(1, value.length)
                              .toLowerCase() ==
                          value.substring(1, value.length).toLowerCase())
                      .toList());
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor: whiteColor,
                hintText: "Cari Karyawan",
                hintStyle: darkGreyTextStyle,
                prefixIcon: Icon(
                  Icons.search,
                  color: darkGreyColor,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => (controller.karyawan.isEmpty)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: scrollController,
                itemCount: (controller.sortingKaryawan.length == 0)
                    ? controller.karyawan.length
                    : controller.sortingKaryawan.length,
                itemBuilder: (context, index) {
                  Karyawan model = (controller.sortingKaryawan.length == 0)
                      ? controller.karyawan[index]
                      : controller.sortingKaryawan[index];

                  return ListTile(
                    onTap: () =>
                        Get.toNamed(Routes.DETAIL_KARYAWAN, arguments: model),
                    title: Text(
                      "${model.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    subtitle: Text(
                      "${model.jabatan}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: darkGreyTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 12,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: darkGreyColor,
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(100),
                      //   child: Image.network(
                      //     loadingBuilder: (context, child, loadingProgress) =>
                      //         loadingProgress == null
                      //             ? child
                      //             : Center(child: CircularProgressIndicator()),
                      //     "https://images.unsplash.com/photo-1709594625825-7c03659c695d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTcxNTgyNTI0OQ&ixlib=rb-4.0.3&q=80&w=1080",
                      //   ),
                      // ),
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Iconsax.call),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Iconsax.message),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: AnimatedSlide(
        offset: widget.isVisible ? Offset.zero : Offset(0, 2),
        duration: Duration(milliseconds: 300),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: widget.isVisible ? 1 : 0,
          child: FloatingActionButton(
            heroTag: "tag1",
            onPressed: () {
              scrollController.jumpTo(0);
              setState(() {
                widget.isVisible = false;
              });
            },
            child: Icon(Icons.arrow_drop_up_outlined),
          ),
        ),
      ),
    );
  }
}
