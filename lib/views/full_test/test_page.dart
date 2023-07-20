// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:red_squirrel/utils/constants/colors.dart';
import 'package:red_squirrel/utils/constants/fonts.dart';
import 'package:red_squirrel/utils/constants/strings.dart';
import 'package:red_squirrel/utils/constants/resources.dart';
import 'package:red_squirrel/utils/constants/test_style.dart';

import 'package:red_squirrel/widgets/answer_button.dart';
import 'package:red_squirrel/widgets/timer.dart';
import 'package:red_squirrel/widgets/question_label.dart';
import 'package:red_squirrel/widgets/submit_button.dart';
import 'package:red_squirrel/widgets/navbar.dart';

import 'package:red_squirrel/components/progress_bar.dart';
import 'package:red_squirrel/components/test_content.dart';

class FullTestPage extends StatefulWidget {
  const FullTestPage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: FullTestPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const FullTestPage());

  @override
  _FullTestPage createState() => _FullTestPage();
}

class _FullTestPage extends State<FullTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(children: [
          //////////// Header ///////////////
          Container(
            padding: const EdgeInsets.only(bottom: 15, top: 49),
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                Strings.fullTestCaption.toUpperCase(),
                style: CustomTextStyle.SectionTitle(
                  ThemeColors.label,
                  30,
                  FontWeight.w900,
                  Fonts.primaryFont,
                  [],
                  2,
                ),
              ),
            ),
          ),

          /////////////Content////////////
          Expanded(
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                clipBehavior: Clip.none,
                decoration: const BoxDecoration(
                  color: ThemeColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Stack(children: [
                  Positioned(
                      bottom: -46,
                      right: -12,
                      width: 280,
                      child: Image.asset(
                        Images.bridge,
                        fit: BoxFit.scaleDown,
                      )),
                  Column(children: [
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        SizedBox(
                          child: CountTimer(
                            timeDuration: 250,
                          ),
                        ),
                      ],
                    ),
                    ProgressBar(count: 24),
                    const SizedBox(
                      height: 26,
                    ),

                    // Expanded(
                    //     child: SingleChildScrollView(
                    //         // child: TestContent(
                    //         //   question:
                    //         //       'Who was the first person to sail single-handed around the world?',
                    //         //   answers: [
                    //         //     'Sr. Francis Drake',
                    //         //     'Sr. Francis Walsingham',
                    //         //     'Sr. Francis Chichester',
                    //         //     'Sr. Robin Knox-Johnston'
                    //         //   ],
                    //         //   condition: false,
                    //         //   count: 4,
                    //         // ),

                    //         // child: TestContent(
                    //         //   question:
                    //         //       'Who was the first person to sail single-handed around the world?Who was the first person to sail single-handed around the world?Who was the first person to sail single-handed around the world?',
                    //         //   answers: [
                    //         //     'Sr. Francis Drake',
                    //         //     'Sr. Francis Walsingham',
                    //         //   ],
                    //         //   condition: false,
                    //         //   count: 2,
                    //         // ),
                    //         )),

                    TestContent(
                      question:
                          'Who was the first person to sail single-handed around the world?',
                      answers: [],
                      condition: true,
                      count: 0,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        SizedBox(
                            child: SubmitButton(
                                text: Strings.submitButton.toUpperCase())),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    )
                  ]),
                ]),
              ),
            ]),
          ),

          ///////////  NavBar ///////////////
          NavBar(),
        ]));
  }
}
