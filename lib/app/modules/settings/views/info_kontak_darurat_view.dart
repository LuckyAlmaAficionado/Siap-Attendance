import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InfoKontakDaruratView extends GetView {
  const InfoKontakDaruratView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoKontakDaruratView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InfoKontakDaruratView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
