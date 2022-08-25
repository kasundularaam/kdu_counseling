import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/components/components.dart';
import '../../../core/configs/configs.dart';
import '../../../core/constants/strings.dart';
import '../../../core/themes/app_colors.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/chat_session.dart';

class ChatPage extends StatefulWidget {
  final AppUser appUser;
  final ChatSession session;
  const ChatPage({
    Key? key,
    required this.appUser,
    required this.session,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  AppUser get appUser => widget.appUser;
  ChatSession get session => widget.session;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return page(
      Column(
        children: [
          backBtnAppBar(
            session.counsellorName,
            context,
            action: session.isAnonymous == 1
                ? ClipOval(
                    child: Container(
                      color: AppColors.light0.withOpacity(0.3),
                      padding: EdgeInsets.all(1.w),
                      child: Image.asset(
                        Strings.anon,
                        width: 7.w,
                        height: 7.w,
                      ),
                    ),
                  )
                : null,
          ),
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:
                  "$chatServer/chat.html?username=${appUser.name}&room=${session.id}",
            ),
          ),
        ],
      ),
    );
  }
}
