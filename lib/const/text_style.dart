import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';

const bold = "bold";
const regular = "regular";
const semiBold = "semiBold";
const light = "light";

ourStyle({family = "regular", double? size = 20, color = whiteColor}) {
  return TextStyle(fontSize: size, color: color, fontFamily: family);
}
