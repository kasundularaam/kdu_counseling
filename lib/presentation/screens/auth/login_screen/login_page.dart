import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../logic/cubit/login_cubit/login_cubit.dart';
import '../../../router/app_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  login() {
    BlocProvider.of<LoginCubit>(context)
        .login(email: emailCtrl.text, password: passwordCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return page(
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpacer(5),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                Strings.landing,
                height: 25.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            vSpacer(10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: textP("login", 22, bold: true)),
            vSpacer(3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  inputEmail(emailCtrl, label: "email"),
                  vSpacer(3),
                  inputPassword(passwordCtrl, label: "password"),
                  vSpacer(3),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSucceed) {
                        navAndClear(context, AppRouter.landingPage);
                      }
                      if (state is LoginFailed) {
                        SnackBar snackBar =
                            SnackBar(content: Text(state.errorMsg));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      }
                      return buttonFilledP("login", () => login());
                    },
                  ),
                  vSpacer(5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
