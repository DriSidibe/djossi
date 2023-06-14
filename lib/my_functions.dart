import 'package:flutter/material.dart';

TextStyle getFontStyleFromMediaSize(BuildContext context, w, h, tVal, fVal) {
  return MediaQuery.of(context).size.width < 384 &&
          MediaQuery.of(context).size.height < 640
      ? tVal
      : fVal;
}
