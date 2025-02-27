import 'package:flutter/material.dart';
import 'package:hemura/ui/auth/pages/login_page.dart';
import 'package:hemura/ui/auth/pages/register_page.dart';

class PageViewAuth extends StatelessWidget {
  PageViewAuth({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Loginpage(pageController: pageController,),
        RegisterPage(pageController: pageController,)
      ],
    );
  }
}
