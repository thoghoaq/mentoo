import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentoo/routes/router.dart';
import 'package:mentoo/routes/routes.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.mBackground,
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                'assets/images/background.svg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: SvgPicture.asset(
                  'assets/images/four_bubble.svg',
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 300,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Text(
                          'Discover your strengths with your mentor',
                          style: AppFonts.bold(24, AppColors.mText),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 50.0, left: 50.0, bottom: 50.0),
                        child: Text(
                          'Mentoo provides quality mentors to help with your career',
                          style: AppFonts.regular(14, AppColors.mText),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mPrimary,
                            fixedSize: const Size(300, 70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    AppRouter.generateRoute(const RouteSettings(
                                        arguments: AppRoutes.signIn)))
                              },
                          child: Text('Get Started',
                              style: AppFonts.bold(25, AppColors.mText))),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Powered by',
                            style: AppFonts.bold(14, AppColors.mGray),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Text('Mentoo',
                              style: AppFonts.bold(20, AppColors.mDarkPurple))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
