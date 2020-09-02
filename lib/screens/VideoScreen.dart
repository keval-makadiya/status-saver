import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:status_save/constants/VideoCard.dart';
import 'package:thumbnails/thumbnails.dart';

final Directory _videoDir = new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    if (!Directory("${_videoDir.path}").existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Install WhatsApp\n",
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            "Your Friend's Status Will Be Available Here",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    } else {
      return VideoItem(
        directory: _videoDir,
      );
    }
  }
}

class VideoItem extends StatefulWidget {
  final Directory directory;

  const VideoItem({Key key, this.directory}) : super(key: key);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  _getImage(videoPathUrl) async {
    String thumbnail = await Thumbnails.getThumbnail(
      videoFile: videoPathUrl,
      imageType: ThumbFormat.PNG,
      quality: 100,
    );
    return thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    var videoList = widget.directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false);

    if (videoList != null) {
      if (videoList.length > 0) {
        return Container(
          child: ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: FutureBuilder(
                      future: _getImage(videoList[index]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return VideoCard(
                              vidThumbnailPath: snapshot.data,
                              videoPath: videoList[index],
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        } else {
                          return Hero(
                            tag: videoList[index],
                            child: Container(
                              height: 280,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                );
//                )
              }),
        );
      } else {
        return Container(
          child: Text(
            "NO Vidoes found!!",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
