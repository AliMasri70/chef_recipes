import 'dart:convert';

import 'package:chef_recipes/services/themeProvider.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:chef_recipes/widgets/flushbar.dart';
import 'package:chef_recipes/widgets/header_main_screen.dart';
import 'package:chef_recipes/widgets/recipe.dart';
import 'package:chef_recipes/widgets/skeleton_shimmer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _pullRefresh() async {
    getRandomMeal();
  }

  List<mealDetail> categoriList = [];
  List<mealDetail> categoriList2 = [];

  bool _isLoading = true;

  void getRandomMeal() async {
    try {
      categoriList.clear();
      categoriList2.clear();
      Response response;
      final dio = Dio();
      Options options = Options(
        receiveTimeout: Duration(milliseconds: 5000),
        sendTimeout: Duration(milliseconds: 5000),
      );
      response = await dio
          .get('https://chefrecipes.net/yummy/getrandommeals.php',
              options: options)
          .whenComplete(() => {
                setState(() {
                  _isLoading = false;
                })
              });

      final jsonData = jsonDecode(response.data);

      int len = jsonData['len'];

      for (int i = 0; i < 5; i++) {
        mealDetail details = new mealDetail();

        details.category = jsonData['meals'][i]['catName'];
        details.image = jsonData['meals'][i]['image'];
        details.mealName = jsonData['meals'][i]['meal'];
        details.country = jsonData['meals'][i]['country'];
        details.idMeal = jsonData['meals'][i]['idmeal'];

        categoriList.add(details);
      }
      print(categoriList[0].idMeal);
      for (int i = 5; i < 10; i++) {
        mealDetail details = new mealDetail();

        details.category = jsonData['meals'][i]['catName'];
        details.image = jsonData['meals'][i]['image'];
        details.mealName = jsonData['meals'][i]['meal'];
        details.country = jsonData['meals'][i]['country'];
        details.idMeal = jsonData['meals'][i]['idmeal'];

        categoriList2.add(details);
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
    final size = MediaQuery.of(context).size;
    bool _isdark = Provider.of<ThemeProvider>(context).getDarkmode;

    return SafeArea(
        child: RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Container(
        color: _isdark ? Colors.black : const Color(0xFFcccccc),
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerMainScreen(),
              SizedBox(
                height: size.height * 0.04,
              ),
              _isLoading
                  ? Container(
                      height: size.height * 0.5,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: ((context, index) {
                            return Container(child: SkeletonShimmer());
                          })),
                    )
                  : Recipe(
                      categoriList: categoriList,
                      sizeCard: 0.3,
                      aspectRatio: 1.07),
              SizedBox(
                height: 30,
              ),
              _isLoading
                  ? Container(
                      height: size.height * 0.5,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: ((context, index) {
                            return Container(child: SkeletonShimmer());
                          })),
                    )
                  : Recipe(
                      categoriList: categoriList2,
                      sizeCard: 0.4,
                      aspectRatio: 1),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
