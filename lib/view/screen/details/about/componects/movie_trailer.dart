
import 'package:flutter/material.dart';

class MovieTrailer extends StatefulWidget {
  const MovieTrailer({
    super.key,
    // required this.futureFiles,
  });
  // final Future<List<FirebaseFile>> futureFiles;

  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
    // return FutureBuilder<List<FirebaseFile>>(
    //   future: widget.futureFiles,
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return Container(
    //           height: 250,
    //           color: Colors.black,
    //           child: const Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       default:
    //         if (snapshot.hasError) {
    //           return const Center(child: Text('Some error occurred!'));
    //         } else {
    //           late VideoPlayerController controller;
    //           late ChewieController chewieController;
    //           final files = snapshot.data!;
    //           log(files.length.toString());
    //           controller =
    //               VideoPlayerController.networkUrl(Uri.parse(files[0].url))
    //                 ..initialize().then((_) {
    //                   setState(() {});
    //                 });
    //
    //           chewieController = ChewieController(
    //             videoPlayerController: controller,
    //             autoPlay: true,
    //             looping: true,
    //           );
    //           return chewieController.videoPlayerController.value.isInitialized
    //               ? AspectRatio(
    //                   aspectRatio: controller.value.aspectRatio,
    //                   child: Chewie(
    //                     controller: chewieController,
    //                   ),
    //                 )
    //               : Container(
    //                   height: 250,
    //                   color: Colors.black,
    //                   child: const Center(
    //                     child: CircularProgressIndicator(),
    //                   ),
    //                 );
    //         }
    //     }
    //   },
    // );
  }
}