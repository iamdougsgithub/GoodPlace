// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/theme.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../widgets/auth_title_widget.dart';

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leadingWidth: 75,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              // width: ,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.red,
                  border: Border.all(color: AppColors.grayTextColor)),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                AuthTitleWidget(title: title),
                Padding(
                  padding: AppPaddings.authScreenHorizontalPadding,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ThemeData authTheme(BuildContext context) {
    return context.theme.copyWith(
      appBarTheme: const AppBarTheme(
        titleSpacing: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: AppColors.authScaffoldColor,
        ),
        backgroundColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.authScaffoldColor,
    );
  }
}
