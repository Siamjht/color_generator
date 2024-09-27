import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class CameraColorPicker extends StatefulWidget {
  @override
  _CameraColorPickerState createState() => _CameraColorPickerState();
}

class _CameraColorPickerState extends State<CameraColorPicker> {
  img.Image? _decodedImage;
  Color? _pickedColor;
  Uint8List? _imageBytes;
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();

  // Function to capture image from the camera
  Future<void> captureImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _loading = true;
      });

      Uint8List bytes = await pickedFile.readAsBytes();
      final img.Image? decodedImage = img.decodeImage(Uint8List.fromList(bytes));

      setState(() {
        _imageBytes = bytes;
        _decodedImage = decodedImage;
        _loading = false;
      });
    }
  }

  // Function to get color from tapped position
  void _getColorAtPosition(Offset position, Size imageSize) {
    if (_decodedImage == null) return;

    double scaleX = imageSize.width / _decodedImage!.width;
    double scaleY = imageSize.height / _decodedImage!.height;

    int pixelX = (position.dx / scaleX).toInt();
    int pixelY = (position.dy / scaleY).toInt();

    // Get pixel color as Pixel object in the updated image package
    img.Pixel pixel = _decodedImage!.getPixelSafe(pixelX, pixelY);

    // Extract RGBA values and convert to Flutter's Color
    setState(() {
      _pickedColor = Color.fromARGB(pixel.a.toInt(), pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt());  // Convert to Flutter's Color
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Capture Image and Pick Color")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: captureImageFromCamera,
              child: Text("Capture Image"),
            ),
            if (_loading) CircularProgressIndicator(),
            if (_imageBytes != null)
              GestureDetector(
                onPanDown: (details) {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  Offset localPosition = box.globalToLocal(details.globalPosition);
                  Size imageSize = box.size;
                  _getColorAtPosition(localPosition, imageSize);
                },
                child: Stack(
                  children: [
                    Image.memory(_imageBytes!),
                    if (_pickedColor != null)
                      Positioned(
                        bottom: 50,
                        left: 20,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: _pickedColor,
                          child: Center(
                            child: Text(
                              '#${_pickedColor!.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
