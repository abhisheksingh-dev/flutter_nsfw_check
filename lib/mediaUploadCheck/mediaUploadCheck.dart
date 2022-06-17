// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsfw/utils/nsfwClass.dart';

class MediaUploadCheck extends StatefulWidget {
  const MediaUploadCheck({Key? key}) : super(key: key);

  @override
  State<MediaUploadCheck> createState() => _MediaUploadCheckState();
}

class _MediaUploadCheckState extends State<MediaUploadCheck> {
  final NSFWDetector _nsfwDetector =
      NSFWDetector('assets/nsfw.tflite', true, true, 2);

  final ImagePicker _picker = ImagePicker();
  bool isTrue = false;
  bool isWait = false;

  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Upload Picture"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (file != null)
              ? Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                    image: DecorationImage(
                      image: Image.file(File(file!.path)).image,
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      (isTrue)
                          ? BoxShadow(
                              color: Colors.red.withOpacity(0.8),
                              spreadRadius: 3.0,
                              blurRadius: 3.0,
                            )
                          : BoxShadow(
                              color: Colors.green.withOpacity(0.8),
                              spreadRadius: 3.0,
                              blurRadius: 3.0,
                            ),
                    ],
                  ),
                  child: (isWait)
                      ? Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Center(
                              child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator())),
                        )
                      : SizedBox(),
                )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    print("true");
                    await pickImage(true);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.camera,
                      size: 40,
                    ),
                  )),
              InkWell(
                  onTap: () async {
                    print("false");
                    await pickImage(false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.photo,
                      size: 40,
                    ),
                  )),
            ],
          ),
          // (file != null)
          //     ? (isTrue)
          //         ? Text(
          //             "Not Safe for work",
          //             style: TextStyle(color: Colors.red),
          //           )
          //         : Text(
          //             "Safe For Work",
          //             style: TextStyle(color: Colors.green),
          //           )
          //     : SizedBox(),
          (file != null)
              ? TextButton(
                  onPressed: () async {
                    setState(() {
                      isWait = true;
                    });
                    var r = await detectNSFWImage(file!.path);
                    setState(() {
                      isWait = false;
                      isTrue = r;
                    });
                    print("this is the result =============> $r");
                  },
                  child: Text("Check"),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Future<dynamic> detectNSFWImage(String photo) async {
    final nsfwStatus = await _nsfwDetector.detectInPhoto(photo);
    //Check the image sensitivity
    if (nsfwStatus > 0.50) {
      return true;
    } else {
      return false;
    }
  }

  pickImage(bool choice) async {
    if (choice) {
      try {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 90,
        );
        setState(() {
          file = pickedFile;
        });
      } catch (e) {
        print(e);
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 90,
        );
        setState(() {
          file = pickedFile;
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
