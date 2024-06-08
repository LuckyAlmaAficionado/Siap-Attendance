import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InfoPeringatanView extends GetView {
  const InfoPeringatanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoPeringatanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InfoPeringatanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
