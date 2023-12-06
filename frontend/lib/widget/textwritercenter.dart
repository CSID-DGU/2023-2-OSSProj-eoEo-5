import 'package:flutter/cupertino.dart';

class TextWritercenter extends StatelessWidget{
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final String contents;
  final Color textColor;

  const TextWritercenter({
    required this.width, required this.fontSize, required this.contents, required this.textColor, required this.fontWeight, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: width * 0.006,
        top: width * 0.006,
        left: width * 0.012,
        right: width * 0.012,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: width * 0.048),
          ),
          Text(contents,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

}