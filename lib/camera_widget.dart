import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;
  int selectedCameraIdx = 0;

  void initialCamera() async {
    cameras = await availableCameras();
  }

  Future disposeCamera() async {
    return await controller.dispose();
  }

  void _onSwitchCamera() {
    print(cameras[selectedCameraIdx]);
    controller =
        CameraController(cameras[selectedCameraIdx], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    initialCamera();
    _onSwitchCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Stack(
      children: <Widget>[
        AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white.withOpacity(0.8)),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.1))
                      ], shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: () {
                      if (selectedCameraIdx == 0) {
                        selectedCameraIdx = 1;
                      } else {
                        selectedCameraIdx = 0;
                      }
                      disposeCamera().then((val) {
                        _onSwitchCamera();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
