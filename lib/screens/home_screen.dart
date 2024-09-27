
import 'package:color_generator/color_picker.dart';
import 'package:color_generator/controllers/color_controller.dart';
import 'package:color_generator/screens/color_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              ColorController.instance.pickImage(ImageSource.camera).then((value) => Get.to(()=> ColorGenerator()),);
            }, child: Text("Get Camera Image")),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              ColorController.instance.pickImage(ImageSource.gallery).then((value) => Get.to(()=> ColorGenerator()),);
            }, child: Text("Get Galary Image")),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              ColorController.instance.pickImage(ImageSource.gallery).then((value) => Get.to(()=> CameraColorPicker()),);
            }, child: Text("Get Color from tapped area")),
          ],
        ),
      ),
    );
  }
}
