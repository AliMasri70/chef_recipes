import 'dart:convert';

import 'package:chef_recipes/screens/vedioPlayer.dart';
import 'package:chef_recipes/services/themeProvider.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:chef_recipes/widgets/constantsWidgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key, required this.idMeal});
  final String idMeal;

  @override
  State<IngredientPage> createState() => _IngredientPageState(idmeal: idMeal);
}

class _IngredientPageState extends State<IngredientPage> {
  _IngredientPageState({required this.idmeal});
  final String idmeal;
  final List<mealIngredients> jsonDataIngred = <mealIngredients>[];

  String? vedio;
  String? prep;
  bool _isLoading = true;
  mealDescription mealDesc = new mealDescription();
  Future _getIngred() async {
    var formData = FormData.fromMap({'idmeal': idmeal});
    try {
      Response response;
      var dio = Dio();
      Options options = Options(
        receiveTimeout: Duration(milliseconds: 5000),
        sendTimeout: Duration(milliseconds: 5000),
      );
      response = await dio
          .post('https://chefrecipes.net/yummy/getIngredients.php',
              data: formData, options: options)
          .whenComplete(() => {
                setState(() {
                  _isLoading = false;
                })
              });

      if (response.statusCode == 200) {
        // print(response.data.toString());

        var f = jsonDecode(response.data);

        int araylength = f['len'];

        setState(() {
          mealDesc.mealVedio = f['meals'][0]['Youtube'];
          mealDesc.mealInstructions = f['meals'][0]['Instructions'];
          mealDesc.mealName = f['meals'][0]['meal'];
          mealDesc.mealCat = f['meals'][0]['Category'];
          mealDesc.country = f['meals'][0]['Area'];
          mealDesc.mealImage = f['meals'][0]['MealThumb'];
        });
        for (int iii = 1; iii < 21; iii++) {
          mealIngredients categoryyy = new mealIngredients();

          setState(() {
            categoryyy.ingredrient = f['meals'][0]['Ingredient$iii'];
            categoryyy.quantity = f['meals'][0]['Measure' + iii.toString()];

            jsonDataIngred.add(categoryyy);
          });
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getIngred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isSwitch = Provider.of<ThemeProvider>(context).getDarkmode;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            _isSwitch ? Colors.black : Color.fromARGB(255, 206, 206, 206),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: _isSwitch ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: (EdgeInsets.only(right: 16)),
            child: (IconButton(
              icon:
                  // ? Icon(Icons.favorite_outlined, color: Colors.red)
                  // :
                  Icon(Icons.favorite_border, color: Colors.black),
              onPressed: () {
                // _setFav(!x);
                // _addFav(phnumber, recipe.idmeal.toString());

                // Icon(Icons.favorite_outlined, color: Colors.green);
              },
            )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isLoading
                      ? skeletonPara(size: size, num: 2)
                      : buildTextTitleVariationdark(
                          mealDesc.mealName.toString()),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 310,
              padding: EdgeInsets.only(left: 16),
              child: Stack(
                children: [
                  Positioned(
                    right: -90,
                    child: Hero(
                      tag: mealDesc.mealImage.toString(),
                      child: _isLoading
                          ? SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                height: 310,
                                width: 310,
                                borderRadius: BorderRadius.circular(35),
                                shape: BoxShape.circle,
                              ),
                            )
                          : Container(
                              height: 310,
                              width: 310,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      mealDesc.mealImage.toString()),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      (buildNutrition(1, "Country", mealDesc.country.toString(),
                          _isSwitch, _isLoading, size)),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariationdark('Ingredients'),
                  _isLoading
                      ? skeletonPara(size: size, num: 3)
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildPopulars(),
                          ),
                        ),
                  SizedBox(
                    height: 16,
                  ),
                  buildTextTitleVariationdark('Recipe preparation'),
                  _isLoading
                      ? skeletonPara(size: size, num: 3)
                      : buildTextTitleIngred(
                          mealDesc.mealInstructions.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return VideoPlayerPopup(
                    videoUrl: mealDesc.mealVedio.toString(),
                  );
                });
          },
          backgroundColor: Color(0xFF4caf53),
          icon: Icon(
            Icons.play_circle_fill,
            color: Colors.white,
            size: 32,
          ),
          label: Text(
            "watch",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  List<Widget> buildPopulars() {
    List<Widget> list = [];
    for (var i = 0; i < jsonDataIngred.length; i++) {
      if (!jsonDataIngred[i].ingredrient.toString().isEmpty) {
        list.add(ingre(jsonDataIngred[i]));
      }
    }
    return list;
  }
}
