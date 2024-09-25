import 'package:cinema_booking_app/utils/color.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

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
        body: const SafeArea(
          child: TabBarView(
            children: [
              SizedBox(),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
