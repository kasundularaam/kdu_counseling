import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/app_user.dart';
import '../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../presentation/screens/auth/widgets/sign_out_view.dart';
import '../constants/strings.dart';
import '../themes/app_colors.dart';

showSnackBar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget page(Widget body) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.light1,
        body: SafeArea(child: body),
      ),
    );

Widget bottomNavPage(Widget body, BottomNavigationBar bar) =>
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
            child: body,
          ),
          bottomNavigationBar: bar),
    );

Widget homeAppBar(String title, BuildContext context, AppUser appUser) {
  return Container(
    color: AppColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
    child: Row(
      children: [
        Expanded(child: textL(title, 18, bold: true)),
        hSpacer(5),
        InkWell(
          onTap: () => showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5.w),
              ),
            ),
            backgroundColor: Colors.white,
            builder: (sheetContext) {
              return BlocProvider(
                create: (context) => SignOutCubit(),
                child: SignOutView(
                  appUser: appUser,
                ),
              );
            },
          ),
          child: ClipOval(
            child: Image.asset(
              Strings.user,
              width: 10.w,
              height: 10.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget simpleAppBar(String title) {
  return Container(
    color: AppColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
    child: Row(
      children: [
        Expanded(
          child: textL(title, 18, bold: true),
        ),
      ],
    ),
  );
}

Widget backBtnAppBar(String title, BuildContext context, {Widget? action}) {
  return Container(
    color: AppColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
    child: Row(
      children: [
        IconButton(
          onPressed: () => navPop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.light0,
          ),
        ),
        hSpacer(3),
        Expanded(
          child: textL(title, 18, bold: true),
        ),
        action ?? nothing
      ],
    ),
  );
}

Widget vSpacer(double height) => SizedBox(height: height.h);
Widget hSpacer(double width) => SizedBox(width: width.w);
Widget get nothing => const SizedBox();

navAndClear(BuildContext context, String route, {dynamic args}) =>
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false,
        arguments: args);

navPush(BuildContext context, String route, {dynamic args}) =>
    Navigator.pushNamed(context, route, arguments: args);

navPop(BuildContext context) => Navigator.pop(context);

Widget viewSpinner() =>
    const CircularProgressIndicator(color: AppColors.primaryColor);

Widget text(String data, double size, Color color,
    {bool? bold, TextAlign? align}) {
  bold = bold ?? false;
  return Text(
    data,
    textAlign: align,
    style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget textP(String data, double size, {bool? bold, TextAlign? align}) {
  bold = bold ?? false;
  return Text(
    data,
    textAlign: align,
    style: TextStyle(
        color: AppColors.primaryColor,
        fontSize: size.sp,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget textD(String data, double size, {bool? bold, TextAlign? align}) {
  bold = bold ?? false;
  return Text(
    data,
    textAlign: align,
    style: TextStyle(
        color: AppColors.dark1,
        fontSize: size.sp,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget textL(String data, double size, {bool? bold, TextAlign? align}) {
  bold = bold ?? false;
  return Text(
    data,
    textAlign: align,
    style: TextStyle(
        color: AppColors.light0,
        fontSize: size.sp,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget inputText(
  TextEditingController controller, {
  String? hint,
  String? label,
  TextAlign? align,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    textAlign: align ?? TextAlign.start,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.w),
      ),
      hintText: hint,
      labelText: label,
    ),
  );
}

Widget inputEmail(
  TextEditingController controller, {
  String? hint,
  String? label,
  TextAlign? align,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    textAlign: align ?? TextAlign.start,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.w),
      ),
      hintText: hint,
      labelText: label,
    ),
  );
}

Widget inputName(
  TextEditingController controller, {
  String? hint,
  String? label,
  TextAlign? align,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.name,
    textAlign: align ?? TextAlign.start,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.w),
      ),
      hintText: hint,
      labelText: label,
    ),
  );
}

Widget inputPassword(
  TextEditingController controller, {
  String? hint,
  String? label,
  TextAlign? align,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.visiblePassword,
    textAlign: align ?? TextAlign.start,
    obscureText: true,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.w),
      ),
      hintText: hint,
      labelText: label,
    ),
  );
}

Widget inputNumber(
  TextEditingController controller, {
  String? hint,
  String? label,
  TextAlign? align,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    textAlign: align ?? TextAlign.start,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.w),
      ),
      hintText: hint,
      labelText: label,
    ),
  );
}

Widget inputPhone(
  TextEditingController controller, {
  String? hint,
  String? label,
  TextAlign? align,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.phone,
    textAlign: align ?? TextAlign.start,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2.w),
      ),
      hintText: hint,
      labelText: label,
    ),
  );
}

Widget buttonFilledP(String text, Function onTap) => ElevatedButton(
      onPressed: () => onTap(),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.light0,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

Widget buttonTextP(String text, Function onTap) => TextButton(
      onPressed: () => onTap(),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

Widget buttonFilled(String text, Function onTap, Color color) => ElevatedButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.light0,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

Widget buttonText(String text, Function onTap, Color color) => TextButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
