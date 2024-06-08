import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import 'package:talenta_app/app/modules/home/controllers/home_controller.dart';
import 'package:talenta_app/app/shared/images/images.dart';
import 'package:talenta_app/app/shared/textfield/textfield_1.dart';

import '../../../models/karyawan.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';

// ignore: must_be_immutable
class KaryawanView extends StatefulWidget {
  KaryawanView({Key? key}) : super(key: key);
  bool isVisible = false;

  @override
  State<KaryawanView> createState() => _KaryawanViewState();
}

class _KaryawanViewState extends State<KaryawanView> {
  final ScrollController scrollController = ScrollController();

  final TextEditingController searchC = TextEditingController();

  final controller = Get.put(HomeController());

  @override
  void initState() {
    // scrollController.addListener(() {
    //   if (scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     if (widget.isVisible != true) {
    //       setState(() {
    //         widget.isVisible = true;
    //       });
    //     }
    //   } else {
    //     if (widget.isVisible != false) {
    //       setState(() {
    //         widget.isVisible = false;
    //       });
    //     }
    //   }
    //   if (scrollController.position.userScrollDirection ==
    //       ScrollDirection.forward) {
    //     if (widget.isVisible != false) {
    //       setState(() {
    //         widget.isVisible = false;
    //       });
    //     }
    //   } else {
    //     if (widget.isVisible != true) {
    //       setState(() {
    //         widget.isVisible = true;
    //       });
    //     }
    //   }
    // });
    super.initState();
  }

  findEmployeeByName(value) {
    if (value.length == 0) {
      controller.sortingKaryawan.clear();
    } else {
      controller.sortingKaryawan(controller.karyawan
          .where((element) =>
              element.name![0].toLowerCase() == value[0].toLowerCase())
          .where((element) =>
              element.name!.substring(1, value.length).toLowerCase() ==
              value.substring(1, value.length).toLowerCase())
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: whiteColor,
        toolbarHeight: 0,
        elevation: 0.5,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: TextField1(
              hintText: "Cari karyawan",
              preffixIcon: HeroIcon(HeroIcons.magnifyingGlass),
              // preffixIcon: Icon(
              //   Iconsax.search_normal_1,
              //   size: 20,
              // ),
              onChanged: findEmployeeByName,
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

                  return Container(
                    margin: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      tileColor: whiteColor,
                      onTap: () =>
                          Get.toNamed(Routes.DETAIL_KARYAWAN, arguments: model),
                      title: Text(
                        "${model.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: normalTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                      subtitle: Text(
                        "${model.jabatan}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: normalTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 10,
                        ),
                      ),
                      leading: CircleAvatar(
                        child: SizedBox(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ImageNetwork(url: model.avatar!),
                          ),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: HeroIcon(HeroIcons.phone),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: HeroIcon(HeroIcons.chatBubbleLeftEllipsis),
                            ),
                          ],
                        ),
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
