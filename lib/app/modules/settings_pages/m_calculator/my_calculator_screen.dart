import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/m_calculator/controller/my_calculator_controller.dart';

import '../../../data/enums/state_status.dart';

class MyCalculatorScreen extends GetView<MyCalculatorController> {
  const MyCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator",style: TextStyle(color: Colors.black87),),
        foregroundColor: Colors.black87,
      ),
      body: Obx(() => controller.stateStatus == StateStatus.LOADING ? const Center(
        child: CircularProgressIndicator(),
      ) : CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  ...List.generate(10, (index) => ListTile(
                    title: Text("List $index"),
                  ))
                ]
            ),
          )
        ],
      )),
    );
  }

}