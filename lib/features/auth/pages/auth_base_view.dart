// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_place/config/theme.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../widgets/auth_app_bar.dart';

class AuthBaseView extends StatelessWidget {
  const AuthBaseView({
    super.key,
    required this.title,
    required this.child,
  });
  final String title;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: authTheme(context),
      child: Scaffold(
        //TODO: Burayı da theme'den al

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            context.dynamicHeight(0.25),
          ),
          child: AuthAppBar(title: title),
        ),
        body: Padding(
          padding: AppPaddings.authScreenHorizontalPadding,
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      ),
    );
  }

  ThemeData authTheme(BuildContext context) {
    return AppTheme().theme.copyWith(
          appBarTheme: AppBarTheme(
            titleSpacing: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: context.dynamicHeight(0.25),
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: AppColors.authScaffoldColor,
            ),
            backgroundColor: Colors.transparent,
          ),
          scaffoldBackgroundColor: AppColors.authScaffoldColor,
        );
  }
}
