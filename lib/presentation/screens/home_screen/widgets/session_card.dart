import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../data/models/chat_session.dart';
import '../../../router/app_router.dart';

class SessionCard extends StatefulWidget {
  final ChatSession session;
  final AppUser appUser;
  const SessionCard({
    Key? key,
    required this.session,
    required this.appUser,
  }) : super(key: key);

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  ChatSession get session => widget.session;
  AppUser get appUser => widget.appUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navPush(context, AppRouter.chatPage,
          args: {"appUser": appUser, "session": session}),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      Strings.counsellor,
                      width: 14.w,
                      height: 14.w,
                    ),
                  ),
                  hSpacer(3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textD(session.counsellorName, 16, bold: true),
                        vSpacer(1),
                        text(
                            session.serviceMethod,
                            12,
                            session.serviceMethod == "ONLINE"
                                ? Colors.green
                                : Colors.blue,
                            bold: true),
                      ],
                    ),
                  ),
                  session.isAnonymous == 1
                      ? ClipOval(
                          child: Container(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            padding: EdgeInsets.all(1.w),
                            child: Image.asset(
                              Strings.anon,
                              width: 6.w,
                              height: 6.w,
                            ),
                          ),
                        )
                      : nothing,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
