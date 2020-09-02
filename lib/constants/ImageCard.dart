import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ImageCard extends StatefulWidget {
  ImageCard({@required this.imgPath});

  final String imgPath;

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.file(
              File(widget.imgPath),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            margin: EdgeInsets.only(left: 10, right: 10, top: 5),
          ),
          Card(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: EdgeInsets.only(right: 8, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    constraints: BoxConstraints(
                      minHeight: 10,
                      minWidth: 10,
                    ),
                    icon: Icon(
                      Icons.save,
                      color: Colors.black54,
                    ),
                    onPressed: () async {
                      String baseName = widget.imgPath.split('/').last;
                      final folderName = 'TestSaver';
                      final path = Directory("storage/emulated/0/$folderName");
                      if ((await path.exists())) {
                        await File(widget.imgPath).copy("storage/emulated/0/$folderName/$baseName");
                        final snackBar = SnackBar(content: Text("Saved Successfully"));
                        Scaffold.of(context).showSnackBar(snackBar);
                      } else {
                        print("Not Exists");
                        path.create();
                        await File(widget.imgPath).copy("storage/emulated/0/$folderName/$baseName");
                      }
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    constraints: BoxConstraints(
                      minWidth: 10,
                      minHeight: 10,
                    ),
                    icon: Icon(
                      Icons.share,
                      size: 24,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      print("done");
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    constraints: BoxConstraints(
                      minWidth: 10,
                      minHeight: 10,
                    ),
                    icon: Icon(
                      Icons.fullscreen,
                      size: 24,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
