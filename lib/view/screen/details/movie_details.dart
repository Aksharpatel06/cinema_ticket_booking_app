import 'package:cinema_booking_app/utils/color.dart';
import 'package:cinema_booking_app/view/screen/details/session/sessions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/movieBloc/home_bloc.dart';
import '../../controller/tabCubit/tab_cubit.dart';
import 'about/about_page.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    super.key,
    required this.homeBloc,
  });

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      bloc: homeBloc,
      builder: (context, state) {
        if (state is HomeAdditionSuccessState) {
          return DefaultTabController(
            length: 2,
            animationDuration: const Duration(milliseconds: 700),
            initialIndex: context.read<TabCubit>().state.index,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: appBarColor,
                leading: const BackButton(
                  color: secondaryColor,
                ),
                centerTitle: true,
                title: Text(
                  state.movieModal.movieName,
                  style: const TextStyle(color: primaryColor),
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
                      modal: state.movieModal,
                    ),
                    const SessionsPage()
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold();
      },
    );
  }
}
