// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension CustomUITheme on BuildContext {
  TextStyle customBold(Color color, double fontSize) {
    return GoogleFonts.titilliumWeb(fontWeight: FontWeight.w700, color: color, fontSize: fontSize);
  }

  TextStyle customRegular(Color color, double fontSize) {
    return GoogleFonts.titilliumWeb(fontWeight: FontWeight.w400, color: color, fontSize: fontSize);
  }

  TextStyle customMedium(Color color, double fontSize) {
    return GoogleFonts.titilliumWeb(fontWeight: FontWeight.w500, color: color, fontSize: fontSize);
  }

  TextStyle customSemiBold(Color color, double fontSize) {
    return GoogleFonts.titilliumWeb(fontWeight: FontWeight.w600, color: color, fontSize: fontSize);
  }

  TextStyle customExtraBold(Color color, double fontSize) {
    return GoogleFonts.titilliumWeb(fontWeight: FontWeight.w800, color: color, fontSize: fontSize);
  }

  EdgeInsets get bodyPadding {
    return const EdgeInsets.only(left: 25, right: 25);
  }

  EdgeInsets get bodyLeftOnly {
    return const EdgeInsets.only(left: 20);
  }

  EdgeInsets get bodyAllPadding {
    return const EdgeInsets.all(25);
  }
}
