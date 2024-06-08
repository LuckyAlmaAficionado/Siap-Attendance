import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InfoKeluargaView extends GetView {
  const InfoKeluargaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoKeluargaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InfoKeluargaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
