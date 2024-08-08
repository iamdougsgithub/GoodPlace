// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';

import '../../../core/constants/app_paddings.dart';
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
    return Scaffold(
      //TODO: Burayı da theme'den al
      backgroundColor: Colors.white,
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
    );
  }
}
