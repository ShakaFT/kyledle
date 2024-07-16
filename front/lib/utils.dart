import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getIcon(String icon) {
  switch (icon) {
    case 'crown':
      return FontAwesomeIcons.crown;
    case 'palette':
      return FontAwesomeIcons.palette;
    default:
      return FontAwesomeIcons.question;
  }
}
