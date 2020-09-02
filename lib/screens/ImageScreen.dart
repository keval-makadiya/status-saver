import 'dart:io';

import 'package:flutter/material.dart';
import 'package:status_save/constants/ImageCard.dart';

final Directory _photoDir = new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Widget build(BuildContext context) {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Install WhatsApp for saving status",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Your contact's status will be shown here",
            style: TextStyle(fontSize: 20),
          ),
        ],
      );
    } else {
      var imgList =
          _photoDir.listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);
      if (imgList.length > 0) {
        return Container(
          margin: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return ImageCard(
                  imgPath: imgList[index],
                );
              }),
        );
      }
    }
  }
}
