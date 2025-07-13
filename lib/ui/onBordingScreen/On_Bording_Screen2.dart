import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:untitled15/l10n/app_localizations.dart';
import 'package:untitled15/ui/Home/Home_Screen/Home_Screen.dart';
import 'package:untitled15/ui/Home/taps/profile/profile_Tap.dart';
import 'package:untitled15/ui/Widgit/On_BOrding_Widgit.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';

class OnBoardingPage extends StatefulWidget {
  static const String routeName='OnBoardingPage';
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
      ),

      pages: [
        PageViewModel(
          bodyWidget: OnBordingWidgit(
            imagePath: AppImages.cat,
            text1: AppLocalizations.of(context)!.find_Events,
            text2: AppLocalizations.of(context)!.text_On_Bording1,
            ),
          title: ''
        ),
        PageViewModel(
            bodyWidget: OnBordingWidgit(
              imagePath: AppImages.critave,
              text1: AppLocalizations.of(context)!.effortless_Event,
              text2: AppLocalizations.of(context)!.text_On_Bording2,
            ),
            title: ''
        ),
        PageViewModel(
            bodyWidget: OnBordingWidgit(
              imagePath: AppImages.tikTok,
              text1: AppLocalizations.of(context)!.connect_with,
              text2: AppLocalizations.of(context)!.text_On_Bording3,
            ),
            title: ''
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  width: 2,
                  color: AppColors.primaryColor
              )
          ),
          child: const Icon(Icons.arrow_back,color: Color(0xff5669FF),)),


      next: Container(
        padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100),
    border: Border.all(
    width: 2,
    color: AppColors.primaryColor
    )
    ),
          child: const Icon(Icons.arrow_forward,color: Color(0xff5669FF),)),
      done:  Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  width: 2,
                  color: AppColors.primaryColor
              )
          ),
          child: const Icon(Icons.arrow_forward,color: Color(0xff5669FF),)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        activeColor: Color(0xff5669FF),
        size: Size(10.0, 10.0),
        color: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
