import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar custom_appbar(
  BuildContext context,
  String title, {
  void Function()? onPressed, // Make onPressed an optional named parameter
}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      color: Colors.white,
      onPressed: onPressed ?? () => Navigator.pop(context),
    ),
  );
}
