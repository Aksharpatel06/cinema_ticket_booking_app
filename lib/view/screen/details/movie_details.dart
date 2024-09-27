import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:cinema_booking_app/utils/color.dart';
import 'package:cinema_booking_app/view/controller/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../helper/storage_services.dart';
import 'about/about_page.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    super.key,
    required this.homeBloc,
    // required this.futureFiles,
  });

  final HomeBloc homeBloc;

  // final Future<List<FirebaseFile>> futureFiles;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.homeBloc.add(HomeInitialFetchEvent());
  }

  void toggle() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc,HomeState>(listener: (context, state) {

    },bloc: widget.homeBloc,builder: (context, state) {
      if(state is HomeDetailsPageState){
        return DefaultTabController(
          length: 2,
          animationDuration: const Duration(milliseconds: 700),
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              leading: BackButton(
                color: secondaryColor,
              ),
              centerTitle: true,
              title:  Text(
                state.movieModal.movieName,
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
                    toggle: toggle,
                    modal: state.movieModal,
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        );
      }
      return Scaffold();
    },);
  }
}

