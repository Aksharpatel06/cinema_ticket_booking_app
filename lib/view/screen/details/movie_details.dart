import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:cinema_booking_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../helper/storage_services.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = StorageServices.storageServices.listAll('movie/');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(milliseconds: 700),
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: const BackButton(
            color: secondaryColor,
          ),
          centerTitle: true,
          title: const Text(
            'Name',
            style: TextStyle(color: primaryColor),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFFFC6C19),
            labelColor: Color(0xFFFC6C19),
            labelStyle: TextStyle(
              shadows: buttonShadow,
            ),
            indicatorWeight: 3,
            unselectedLabelColor: secondaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: 'About',
              ),
              Tab(
                text: 'Sessions',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              // AboutPage(
              //   controller: controller,
              //   chewieController: chewieController,
              // ),
              FutureBuilder<List<FirebaseFile>>(
                future: futureFiles,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Some error occurred!'));
                      } else {
                        late VideoPlayerController controller;
                        late ChewieController chewieController;
                        final files = snapshot.data!;
                        log(files.length.toString());
                        controller = VideoPlayerController.networkUrl(
                            Uri.parse(files[0].url))
                          ..initialize().then((_) {
                            setState(() {});
                          });

                        chewieController = ChewieController(
                          videoPlayerController: controller,
                          autoPlay: true,
                          looping: true,
                        );
                        return AboutPage(
                            controller: controller,
                            chewieController: chewieController);
                      }
                  }
                },
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    required this.controller,
    required this.chewieController,
  });

  final VideoPlayerController controller;
  final ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        chewieController.videoPlayerController.value.isInitialized
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
              ),
        Container(
          width: double.infinity,
          height: 70.h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0x001E283D), Color(0xFF1E283D)],
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2 - 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '8.3',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'IMDB',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
              const VerticalDivider(
                color: Color(0x196D9DFF),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2 - 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '7.9',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Kinopoisk',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              'When the Riddler, a sadistic serial killer, begins murdering key political figures in Gotham, Batman is forced to investigate the city\'s hidden corruption and question his family\'s involvement.',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  'Certificate',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  padding:
                       EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0x196D9DFF)),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Text(
                    '16+',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Runtime',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '02:56',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Genre',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '02:56',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
