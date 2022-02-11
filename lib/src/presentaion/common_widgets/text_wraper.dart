import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';

class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _TextWrapperState createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
              constraints: isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 70),
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 15, color: AppColors.goldenColor),
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      isExpanded
          ? OutlinedButton.icon(
              icon: Icon(
                Icons.arrow_upward,
                color: AppColors.appGrey,
              ),
              label: Text(
                'Read less',
                style: TextStyle(color: AppColors.goldenColor),
              ),
              onPressed: () => setState(() => isExpanded = false))
          : TextButton.icon(
              icon: Icon(
                Icons.arrow_downward,
                color: AppColors.appGrey,
              ),
              label: Text(
                'Read more',
                style: TextStyle(color: AppColors.goldenColor),
              ),
              onPressed: () => setState(() => isExpanded = true))
    ]);
  }
}
