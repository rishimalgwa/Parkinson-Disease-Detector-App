import 'package:flutter/material.dart';

final TextStyle regularText = TextStyle();

final TextStyle smallText = regularText.copyWith(
  fontSize: 12,
);

final TextStyle appBarSmallText = regularText.copyWith(
  fontSize: 14,
);
final TextStyle appBarBigText =
    regularText.copyWith(fontSize: 24, fontWeight: FontWeight.w600);
final TextStyle mediumText =
    regularText.copyWith(fontSize: 18, fontWeight: FontWeight.w600);
final TextStyle bigHeadingText =
    regularText.copyWith(fontSize: 30, fontWeight: FontWeight.bold);

// InputDecoration authTextFieldDecoration = InputDecoration(
//   hintStyle: const TextStyle(fontSize: 14),
//   filled: true,
//   fillColor: AppColors.cardColor,
//   border: const UnderlineInputBorder(
//     borderRadius: BorderRadius.all(
//       Radius.circular(10),
//     ),
//     borderSide: BorderSide.none,
//   ),
//   disabledBorder: const UnderlineInputBorder(
//     borderRadius: BorderRadius.all(
//       Radius.circular(10),
//     ),
//     borderSide: BorderSide.none,
//   ),
//   enabledBorder: const UnderlineInputBorder(
//     borderRadius: BorderRadius.all(
//       Radius.circular(10),
//     ),
//     borderSide: BorderSide.none,
//   ),
// );
