import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/components.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/app_user.dart';
import '../../../logic/cubit/sessions_cubit/sessions_cubit.dart';
import 'widgets/session_card.dart';

class HomePage extends StatefulWidget {
  final AppUser appUser;
  const HomePage({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppUser get appUser => widget.appUser;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SessionsCubit>(context).loadSessions();
    return page(Column(
      children: [
        homeAppBar(Strings.appTitle, context, appUser),
        BlocConsumer<SessionsCubit, SessionsState>(
          listener: (context, state) {
            if (state is SessionsFailed) {
              showSnackBar(context, state.errorMsg);
            }
          },
          builder: (context, state) {
            if (state is SessionsLoading) {
              return Expanded(
                child: Center(
                  child: viewSpinner(),
                ),
              );
            }
            if (state is SessionsNoSessions) {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Image.asset(
                        Strings.no,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    textP("No Sessions", 14, bold: true),
                  ],
                ),
              );
            }
            if (state is SessionsLoaded) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  itemCount: state.sessions.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SessionCard(
                      appUser: appUser,
                      session: state.sessions[index],
                    );
                  },
                ),
              );
            }
            return nothing;
          },
        )
      ],
    ));
  }
}
