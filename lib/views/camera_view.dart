import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:detector_rostro/controllers/scan_controller.dart';


class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Multimedia detector",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.deepPurple),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.purple,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          return Stack(
            children: [
              controller.isCameraInitialized.value
                  ? Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  child: SizedOverflowBox(
                    size: Size(screenWidth * 0.8, screenHeight * 0.5),
                    alignment: Alignment.center,
                    child: CameraPreview(controller.cameraController),
                  ),
                ),
              )
                  : Container(
                width: MediaQuery.of(context).size.width,
                height: 682,
                color: Colors.purple.shade100,
              ),
              controller.label == "fernanda"
                  ? Center(
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsetsDirectional.only(bottom: 0, end: 0, top: 450, start: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Individuo resultante : ${controller.label.capitalizeFirst}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: AutofillHints.addressCity,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        width: 100.0,
        height: 100.0,
        margin: const EdgeInsets.only(bottom: 70.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.purple, width: 2.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 70.0,
                height: 70.0,
                child: GetBuilder<ScanController>(
                  init: ScanController(),
                  builder: (controller) {
                    return FloatingActionButton(
                      onPressed: () {
                        if (controller.isCameraInitialized.value) {
                          controller.stopCamera();
                          controller.label = "";
                        } else {
                          controller.initCamera();
                        }
                      },
                      backgroundColor: Colors.purple.shade200,
                      shape: const CircleBorder(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}