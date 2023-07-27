import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';




class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {

  File? _image;
  CroppedFile? _croppedFile;
  final picker = ImagePicker();

  Future<void> _cropImage() async{
    if(_image != null){
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null){
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }
  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text(style: TextStyle(fontSize: 30),'치아 샘플을 준비해 주신 뒤 \n밝은 곳에서 촬영해 주세요!')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25.0),
            showImage(),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  heroTag: "btn5",
                  tooltip: 'pick Image',
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Icon(Icons.add_a_photo),
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  heroTag: "btn3",
                  tooltip: 'pick Image',
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Icon(Icons.wallpaper),
                ),

                FloatingActionButton(
                  heroTag: "btn4",
                  tooltip: 'crop image',
                  onPressed: () {
                    _cropImage();
                  },
                  child: Icon(Icons.search),
                ),
              ],
            )
          ],
        ));
  }
}
