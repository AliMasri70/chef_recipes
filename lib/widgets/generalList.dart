import 'package:chef_recipes/screens/meals.dart';
import 'package:chef_recipes/services/themeProvider.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralList extends StatelessWidget {
  GeneralList({super.key, required this.titleLead, required this.imageLead});

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
            print(titleLead);
            Navigator.push(
              context,
              CustomRoute(
                  builder: (context) => MealList(
                        type: "category",
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
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30.0,
                    backgroundImage: NetworkImage("$imageLead"),
                  ),
                  title: Text("$titleLead"),
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
