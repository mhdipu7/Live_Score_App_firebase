import 'package:flutter/material.dart';
import 'package:live_football_score/data/model/football.dart';
import 'package:live_football_score/view/widgets/rich_text_two_widget.dart';

class LiveListItemWidget extends StatelessWidget {
  const LiveListItemWidget({
    super.key,
    required this.football,
  });

  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfffffbfb),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichTextTwoWidget(
              firstText: football.team01Goal.toString(),
              secondText: "\n${football.team01Name}",
              firstTextColor: Colors.black,
              secondTextColor: Colors.black,
              firstTextSize: 22,
              secondTextSize: 18,
              firstTextFontWeight: FontWeight.w600,
              secondTextFontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              height: 1.5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "vs",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            RichTextTwoWidget(
              firstText: football.team02Goal.toString(),
              secondText: "\n${football.team02Name}",
              firstTextColor: Colors.black,
              secondTextColor: Colors.black,
              firstTextSize: 22,
              secondTextSize: 18,
              firstTextFontWeight: FontWeight.w600,
              secondTextFontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              height: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
