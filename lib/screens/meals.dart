import 'dart:convert';

import 'package:chef_recipes/screens/ingredientPage.dart';
import 'package:chef_recipes/services/themeProvider.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:chef_recipes/widgets/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MealList extends StatefulWidget {
  final String type;
  final String name;

  const MealList({super.key, required this.type, required this.name});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MealList> {
  List<mealDetail> categoriList = [];

  bool _isLoading = true;

  void getRandomMeal() async {
    String url = "";
    if (widget.type.toString() == "category") {
      url = "https://chefrecipes.net/yummy/getmeal.php";
    } else {
      url = "https://chefrecipes.net/yummy/getmealbycountry.php";
    }
    print(url + " // " + widget.name);
    try {
      categoriList.clear();
      Response response;
      final dio = Dio();
      var formData = FormData.fromMap({'catName': widget.name});
      Options options = Options(
        receiveTimeout: Duration(milliseconds: 5000),
        sendTimeout: Duration(milliseconds: 5000),
      );
      response = await dio
          .post(url, data: formData, options: options)
          .whenComplete(() => {
                setState(() {
                  _isLoading = false;
                })
              });

      final jsonData = jsonDecode(response.data);

      int len = jsonData['len'];
      print(jsonData);

      for (int i = 0; i < len; i++) {
        mealDetail details = new mealDetail();

        details.category = jsonData['meals'][i]['catName'];
        details.image = jsonData['meals'][i]['image'];
        details.mealName = jsonData['meals'][i]['meal'];
        details.country = jsonData['meals'][i]['country'];
        details.idMeal = jsonData['meals'][i]['idmeal'];

        categoriList.add(details);
      }
    } on DioError catch (e) {
      setState(() {
        _isLoading = true;
      });
      // Handle Dio error
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        // Handle timeout error
        FlushBarWidget("Error", "Error Receiving Categories!").show(context);

        print("Timeout error: ${e.message}");
      } else if (e.type == DioErrorType.connectionError) {
        // Handle non-2xx response error
        FlushBarWidget("Error", "Error Receiving Categories!").show(context);
        print("Non-2xx response error: ${e.message}");
      } else {
        // Handle other Dio errors
        print("Other Dio error: ${e.message}");
        FlushBarWidget("Error", "Error Receiving Categories!").show(context);
      }
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
      // Handle other errors
    }
  }

  @override
  void initState() {
    getRandomMeal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _darkMode = Provider.of<ThemeProvider>(context).getDarkmode;

    return Scaffold(
      backgroundColor:
          _darkMode ? Colors.black : Color.fromARGB(255, 206, 206, 206),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.arrow_back,
                    color: _darkMode
                        ? Color.fromARGB(255, 206, 206, 206)
                        : Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: categoriList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomRoute(
                              builder: (context) => IngredientPage(
                                    idMeal: categoriList[index].idMeal,
                                  )),
                        );
                        // print(categoriList[index].idMeal);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: categoriList[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
