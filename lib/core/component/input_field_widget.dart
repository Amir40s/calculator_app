import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../../config/res/app_icons.dart';
import '../../config/res/app_text_style.dart';
import '../../config/res/statics.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({super.key});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  final TextEditingController inputTextController = TextEditingController();
  final static = Statics();

  @override
  void dispose() {
    inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      smoothness: 0.8,
      width: 100.w,
      borderRadius: BorderRadius.circular(20.px),
      height: static.inputContainerHeight,
      side: BorderSide(
        color: Theme.of(context).primaryColorDark.withOpacity(0.4),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 10.px),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: inputTextController,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          onSubmitted: (val) {},
                          textAlignVertical: TextAlignVertical.top,
                          style: AppTextStyle().bodyText(context: context),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a mood or keyword",
                            hintStyle: const TextStyle(color: Colors.grey),
                            isDense: true,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (inputTextController.text.isNotEmpty) {
                                clearText();
                              } else {
                                pasteText();
                              }
                            },
                            child: SvgPicture.asset(
                              inputTextController.text.isNotEmpty
                                  ? AppIcons.delete
                                  : AppIcons.pasteSvg,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).primaryColorDark,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void pasteText() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final pastedText = clipboardData?.text ?? '';
    if (pastedText.isNotEmpty) {
      inputTextController.text = pastedText;
      inputTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: inputTextController.text.length),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No text found to paste")),
      );
    }
  }

  void clearText() {
    inputTextController.clear();
  }
}
