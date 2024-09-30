import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovieTrailer extends StatefulWidget {
  const MovieTrailer({
    super.key,
    required this.videoUrl,
  });

  final Uri videoUrl;

  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  late VideoPlayerController controller;
  late ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.videoUrl.toString());

    try{
      controller = VideoPlayerController.networkUrl(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {});
        });

      chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
      );
    } catch(e)
    {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chewieController.videoPlayerController.value.isInitialized
        ? AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Chewie(
              controller: chewieController,
            ),
          )
        : Container(
            height: 250,
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
