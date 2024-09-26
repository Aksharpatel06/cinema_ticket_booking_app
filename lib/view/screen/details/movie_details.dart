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

  void toggle()
  {
    setState(() {

    });
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
              AboutPage(
                futureFiles: futureFiles,
                toggle: toggle,
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
    required this.futureFiles,
    required this.toggle,
  });

  final Future<List<FirebaseFile>> futureFiles;
  final VoidCallback toggle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
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
                            toggle();
                          });

                        chewieController = ChewieController(
                          videoPlayerController: controller,
                          autoPlay: true,
                          looping: true,
                        );
                        return chewieController
                                .videoPlayerController.value.isInitialized
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
                },
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'When the Riddler, a sadistic serial killer, begins murdering key political figures in Gotham, Batman is forced to investigate the city\'s hidden corruption and question his family\'s involvement.',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Certificate',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.h, vertical: 4.h),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0x196D9DFF)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Runtime',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 35.h,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Release',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 38.h,
                          ),
                          Text(
                            '2020',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Genre',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 52.h,
                          ),
                          Text(
                            'Action, Crime, Drama',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Director',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 37.h,
                          ),
                          Text(
                            'Matt Reeves',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cast',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 62.h,
                          ),
                          SizedBox(
                            width: 240.h,
                            child: Text(
                              'Robert Pattinson, Zoë Kravitz, Jeffrey Wright, Colin Farrell, Paul Dano, John Turturro, Andy Serkis, Peter Sarsgaard',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 88.h,
            padding: EdgeInsets.all(16.h),
            decoration: const BoxDecoration(color: Color(0xB21E283D)),
            child: Container(
              width: 343.h,
              height: 56.h,
              decoration: ShapeDecoration(
                  gradient: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  shadows: buttonShadow),
              child: const Text(
                'Select session',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
