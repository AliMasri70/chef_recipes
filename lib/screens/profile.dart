import 'package:chef_recipes/services/theme_data.dart';
import 'package:chef_recipes/widgets/constantsWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../services/themeProvider.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  String addr = "";
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              SizedBox(
                height: 5,
              ),
              SwitchListTile(
                title: const Text(
                  "Theme",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                secondary: themeProvider.getDarkmode
                    ? Icon(Icons.dark_mode_outlined)
                    : Icon(Icons.light_mode_outlined),
                onChanged: (value) {
                  setState(() {
                    themeProvider.setthemeMode = value;
                  });
                },
                value: themeProvider.getDarkmode,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 18),
                child: Divider(
                  height: 5,
                  color:
                      themeProvider.getDarkmode ? Colors.white : Colors.black,
                ),
              ),

              VariableListTile(
                  IconLeading: Icon(IconlyLight.profile),
                  Title: "Address",
                  Subtitle: "Subtitle",
                  onTapTitle: () => {}),
            ],
          ),
        ),
      ),
    );
  }
}
