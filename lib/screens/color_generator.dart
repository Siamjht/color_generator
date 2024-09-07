import 'dart:io';

import 'package:color_generator/controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorGenerator extends StatefulWidget {
  const ColorGenerator({super.key});

  @override
  _ColorGeneratorState createState() => _ColorGeneratorState();
}

class _ColorGeneratorState extends State<ColorGenerator> {
  PaletteGenerator? paletteGenerator;
  ColorController controller = Get.put(ColorController());

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      FileImage(
          File(controller.selectedImagePath.value)), // Replace with your image
    );
    setState(() {
      paletteGenerator = generator;
      print("Image generate: ${paletteGenerator?.dominantColor?.color}");
    });
  }

  String getHexFromColor(Color color) {
    controller.getColorNameRepo(hexColorCode: color.value.toRadixString(16).substring(2));
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    Color? dominantColor = paletteGenerator?.dominantColor?.color;
    String hexColor = dominantColor != null ? getHexFromColor(dominantColor) : 'No Color';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color From Image'),
      ),
      body: paletteGenerator != null
          ? Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                          color: dominantColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4))
                          ]),
                      child: Obx(() => controller.isLoading.value? Center(child: const CircularProgressIndicator()) : Text("Color Name: ${controller.colorName}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),) ),
                    ),
                    const SizedBox(height: 12,),
                    Text('Dominant Color Hex: $hexColor'),
                  ]
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
