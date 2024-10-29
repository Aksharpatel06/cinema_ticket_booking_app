import 'package:cinema_booking_app/utils/color.dart';
import 'package:cinema_booking_app/view/screen/details/session/sessions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/movieBloc/home_bloc.dart';
import '../../controller/tabCubit/tab_cubit.dart';
import 'about/about_page.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.homeBloc});

  final HomeBloc homeBloc;

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this, animationDuration: const Duration(milliseconds: 1500));

    context.read<TabCubit>().stream.listen((state) {
      _tabController.animateTo(state.index,duration: const Duration(milliseconds: 1500));
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      bloc: widget.homeBloc,
      builder: (context, state) {
        if (state is HomeAdditionSuccessState) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              leading: const BackButton(color: secondaryColor),
              centerTitle: true,
              title: Text(
                state.movieModal.movieName,
                style: const TextStyle(color: primaryColor),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFFFC6C19),
                labelColor: const Color(0xFFFC6C19),
                labelStyle: const TextStyle(shadows: buttonShadow),
                indicatorWeight: 3,
                unselectedLabelColor: secondaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Sessions'),
                ],
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  AboutPage(modal: state.movieModal),
                  SessionsPage(movieModal: state.movieModal),
                ],
              ),
            ),
          );
        }
        return const Scaffold();
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
