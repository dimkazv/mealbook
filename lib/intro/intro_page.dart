import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:template_bloc/common/routes.dart';
import 'package:template_bloc/common/ui/app_assets.dart';
import 'package:template_bloc/common/ui/app_colors.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  void _onSlideButton(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.splashPic),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Cooking Experience Like a Chief',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(48, 24, 48, 56),
                  child: Text(
                    "Let's make a delicious dish with the best recipe for you",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(64, 0, 64, 36),
                  child: ConfirmationSlider(
                    onConfirmation: () => _onSlideButton(context),
                    text: 'Get started',
                    textStyle: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: AppColors.accent,
                    width: 250,
                    foregroundColor: AppColors.primary,
                    sliderButtonContent: const Icon(
                      Icons.double_arrow_rounded,
                      color: AppColors.accent,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
