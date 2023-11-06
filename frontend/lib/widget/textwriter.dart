import 'package:flutter/cupertino.dart';

class TextWriter extends StatelessWidget{
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final String contents;
  final Color textColor;

  const TextWriter({
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
        children: <Widget>[
/*
          Icon(
            Icons.favorite,
            color: Colors.pinkAccent,
            size: width * 0.03,
          ),
*/
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
