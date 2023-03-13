import 'package:chef_recipes/services/themeProvider.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

Widget VariableListTile(
    {required String Title,
    required String Subtitle,
    required Function onTapTitle,
    required Icon IconLeading}) {
  return ListTile(
    title: Text(
      Title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(Subtitle),
    leading: IconLeading,
    trailing: Icon(IconlyLight.arrowRight2),
    onTap: () {
      onTapTitle();
    },
  );
}

Widget buttonTabs(
    {required String audioAvailable,
    required BuildContext context,
    required String extension,
    required String quality,
    required String videoavailable,
    required Function onPress,
    required String downloadSize}) {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: themeProvider.getDarkmode
          ? Color.fromARGB(255, 30, 30, 34)
          : Color.fromARGB(255, 206, 206, 206),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.download, size: 24, color: Colors.red),
            ),
            Text("Size: $downloadSize"),
            Text("Format: $extension"),
            Text("Quality: $quality"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                audioAvailable != "true"
                    ? const Icon(Icons.music_off, size: 24, color: Colors.red)
                    : const Icon(Icons.music_note, size: 24, color: Colors.red),
                videoavailable == "true"
                    ? const Icon(Icons.video_call, size: 24, color: Colors.red)
                    : const Icon(Icons.videocam_off,
                        size: 24, color: Colors.red),
              ],
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              onPress();
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              padding: const EdgeInsets.all(12),
              child: const Center(child: Text("Download")),
            ),
          ),
        )
      ],
    ),
  );
}

buildTextTitleVariationdark(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: GoogleFonts.playfairDisplay(fontSize: 30),
    ),
  );
}

buildTextTitleIngred(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: GoogleFonts.playfairDisplay(fontSize: 17),
    ),
  );
}

Widget ingre(mealIngredients mealIngredients) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: (Row(
      children: [
        Text(
          "* ",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        buildTextTitleIngred(mealIngredients.ingredrient.toString().trim() +
            " : " +
            mealIngredients.quantity.toString().trim())
      ],
    )),
  );
}

Widget buildNutrition(int value, String title, String subTitle, bool _isDark,
    bool _isload, Size size) {
  return Container(
    height: 60,
    width: 150,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      boxShadow: [kBoxShadow],
    ),
    child: Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [kBoxShadow],
          ),
          child: Center(
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                // color: _isSwitch ? Colors.black : Colors.white,
              ),
            ),
            _isload
                ? skeletonPara(size: size / 4, num: 1)
                : Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: _isDark ? Colors.black : Colors.white,
                    ),
                  ),
          ],
        ),
      ],
    ),
  );
}

class skeletonPara extends StatelessWidget {
  const skeletonPara({
    super.key,
    required this.size,
    required this.num,
  });

  final Size size;
  final int num;

  @override
  Widget build(BuildContext context) {
    return SkeletonParagraph(
      style: SkeletonParagraphStyle(
          lines: num,
          spacing: 10,
          lineStyle: SkeletonLineStyle(
            alignment: AlignmentDirectional.centerStart,
            randomLength: true,
            height: 10,
            borderRadius: BorderRadius.circular(8),
            minLength: size.width / 1.6,
            maxLength: size.width / 1.5,
          )),
    );
  }
}
