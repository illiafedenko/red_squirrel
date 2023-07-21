// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, duplicate_ignore, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';
import 'package:red_squirrel/views/chapter_test/main_page.dart';
import 'package:red_squirrel/views/full_test/feedback_page.dart';
import 'package:red_squirrel/views/full_test/test_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
  });

  // static method to create a page with no arguments
  static Page<void> page() => const MaterialPage<void>(child: ResultPage());

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const ResultPage());

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  // lifecycle method called when the state object is created
  bool isResultSectionVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _fadeInAnimation = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isResultSectionVisible = true;
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // variable
  int corrected = 17;
  var dataPercent = 0.73;
  var time = 1806;

  // helper method to build a button widget
  GestureDetector _buildButton(String icon, String label, int type) {
    return GestureDetector(
      onTap: () {
        switch (type) {
          case 1:
            // This is widget in full_test/feedback_page
            Navigator.of(context).push<void>(FeedbackPage.route());
            break;
          case 2:
            Navigator.of(context).push<void>(MainPage.route());
            break;
          case 3:
            Navigator.of(context).push<void>(FullTestPage.route());
            break;
          case 4:
            _showExitModalDialog(context);
            break;
          default:
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            color: ThemeColors.secondary,
          ),
          SizedBox(height: 10),
          Text(label, style: CustomTextStyle.SpanText(ThemeColors.secondary))
        ],
      ),
    );
  }

  _showExitModalDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit an App'),
          actions: [
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text('Yes'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No"))
          ],
        );
      },
    );
  }

  // build method for the ResultPage widget
  @override
  Widget build(BuildContext context) {
    Widget statusSection = Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child:
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  TweenAnimationBuilder(
                    tween: IntTween(begin: 0, end: corrected),
                    duration: Duration(milliseconds: 3000),
                    builder: (context, int value, child) => Text("$value / 24",
                        style:
                            CustomTextStyle.LabelText(ThemeColors.secondary)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Visibility(
                  //   visible: isResultSectionVisible,
                  //   child:
                  Text(corrected > 17 ? "Passed" : "Failed",
                      style: CustomTextStyle.LabelText(ThemeColors.secondary)),
                  // )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TweenAnimationBuilder(
                  tween: IntTween(begin: 0, end: (dataPercent * 100).toInt()),
                  duration: Duration(milliseconds: 3000),
                  builder: (context, int value, child) =>
                      CircularPercentIndicator(
                        radius: 80,
                        lineWidth: 22,
                        animation: true,
                        animationDuration: 3000,
                        animateFromLastPercent: true,
                        percent: dataPercent,
                        center: Text(
                          '$value%',
                          style: CustomTextStyle.HeaderTitleText(
                              ThemeColors.secondary),
                        ),
                        progressColor: Color.lerp(ThemeColors.failedProgressbar,
                            ThemeColors.successProgressbar, value / 100),
                        backgroundColor: ThemeColors.progressBar,
                        circularStrokeCap: CircularStrokeCap.round,
                      )),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      TweenAnimationBuilder(
                        tween: IntTween(begin: 0, end: time ~/ 60),
                        duration: Duration(milliseconds: 3000),
                        builder: (context, int value, child) => Text("$value:",
                            style: CustomTextStyle.LabelText(
                                ThemeColors.secondary)),
                      ),
                      TweenAnimationBuilder(
                        tween: IntTween(begin: 0, end: time % 60),
                        duration: Duration(milliseconds: 2000),
                        builder: (context, int value, child) => Text(
                            time % 60 > 10 ? "$value" : "0$value",
                            style: CustomTextStyle.LabelText(
                                ThemeColors.secondary)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Time",
                      style: CustomTextStyle.LabelText(ThemeColors.secondary)),
                ],
              ),
            )
          ],
        ));
    // );
    Widget resultSection = Visibility(
        visible: isResultSectionVisible,
        child: FadeTransition(
            opacity: _fadeInAnimation,
            child: Container(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Text(corrected > 17 ? "Congratulations!" : "Whoops, sorry",
                      style:
                          CustomTextStyle.SectionTitle(ThemeColors.secondary)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    corrected > 17
                        ? "You have passed the test."
                        : "You have failed the test.",
                    style: TextStyle(
                      color: Color(0xFF012169),
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            )));

    Widget buttonSection = Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 70),
        child: Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                SvgIcons.line2,
                color: ThemeColors.secondary,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                SvgIcons.line1,
                width: MediaQuery.of(context).size.width - 80,
                color: ThemeColors.secondary,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                SvgIcons.rectangle,
                width: 60,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                SvgIcons.diamond,
                width: 36,
                color: ThemeColors.secondary,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(SvgIcons.checkResult, "Check results", 1),
                  _buildButton(SvgIcons.numberList, "Test by Chapter", 2)
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(SvgIcons.restart, "Restart test", 3),
                  _buildButton(SvgIcons.exit, "Exit the App", 4)
                ],
              )
            ],
          ),
        ]));

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15, top: 49),
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: Center(
              child: Text(Strings.fullTest.toUpperCase(),
                  style: CustomTextStyle.SectionTitle(ThemeColors.label)),
            ),
          ),
          Expanded(
            child: Stack(children: [
              Container(
                height: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                decoration: const BoxDecoration(
                  color: ThemeColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    statusSection,
                    resultSection,
                    buttonSection,
                  ],
                ),
              ),
            ]),
          ),
        ]));
  }
}
