import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class headerMainScreen extends StatelessWidget {
  const headerMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Looking for your Favourite Meal",
              style: GoogleFonts.playfairDisplay(fontSize: 30),
            ),
          ),
          IconButton(
              iconSize: 30,
              color: Colors.red,
              onPressed: () {},
              icon: Icon(Icons.favorite))
        ],
      ),
    );
  }
}
