import 'package:chef_recipes/screens/meals.dart';
import 'package:chef_recipes/services/themeProvider.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GeneralListCountry extends StatelessWidget {
  GeneralListCountry(
      {super.key, required this.titleLead, required this.imageLead});

  String titleLead;
  String imageLead;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.push(
              context,
              CustomRoute(
                  builder: (context) => MealList(
                        type: "country",
                        name: titleLead,
                      )),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: titleLead != "Unknown"
                      ? SvgPicture.network(
                          "$imageLead",
                          semanticsLabel: 'image',

                          // width: 24,
                          // height: 24,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Image.network(
                            "$imageLead",
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                          ),
                        ),
                  title: titleLead != "Unknown"
                      ? Text("$titleLead")
                      : Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text("$titleLead"),
                        ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            color: themeProvider.getDarkmode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
