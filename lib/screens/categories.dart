import 'dart:convert';

import 'package:chef_recipes/services/themeProvider.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:chef_recipes/widgets/flushbar.dart';
import 'package:chef_recipes/widgets/generalList.dart';
import 'package:chef_recipes/widgets/skeleton_listCategory.dart';
import 'package:chef_recipes/widgets/skeleton_shimmer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<categories> categoriList = [];
  bool _isLoading = true;
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  Future<void> getCategories() async {
    try {
      categoriList.clear();
      Response response;
      final dio = Dio();
      Options options = Options(
        receiveTimeout: Duration(milliseconds: 5000),
        sendTimeout: Duration(milliseconds: 5000),
      );
      response = await dio
          .get('https://chefrecipes.net/yummy/getcategories.php',
              options: options)
          .whenComplete(() => {
                setState(() {
                  _isLoading = false;
                })
              });

      final jsonData = jsonDecode(response.data);
      print(jsonData['categories'][0]['category']);
      print(jsonData['len']);

      int len = jsonData['len'];
      for (int i = 0; i < len; i++) {
        categories details = new categories();

        details.category = jsonData['categories'][i]['category'];
        details.categoryImage = jsonData['categories'][i]['categoryImage'];

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
        FlushBarWidget("Error", "Connection Error!").show(context);

        print("Timeout error: ${e.message}");
      } else if (e.type == DioErrorType.connectionError) {
        // Handle non-2xx response error
        FlushBarWidget("Error", "Connection Error!").show(context);
        print("Non-2xx response error: ${e.message}");
      } else {
        // Handle other Dio errors
        print("Other Dio error: ${e.message}");
        FlushBarWidget("Error", "Connection Error!").show(context);
      }
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
      // Handle other errors
    }
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _isLoading = true;
    });
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool _isdark = Provider.of<ThemeProvider>(context).getDarkmode;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: _isLoading
            ? Container(
                height: size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      return Container(child: SkeletonListCategory());
                    })),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: _isdark
                      ? Colors.black
                      : Color.fromARGB(255, 206, 206, 206),
                  elevation: 0,
                  title: Row(
                    children: [
                      Icon(
                        Icons.category,
                        color: Color(0xFF4caf53),
                        size: size.height * 0.05,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Categories",
                            style: GoogleFonts.playfairDisplay(
                                fontSize: 30,
                                color: _isdark ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Container(
                    child: ListView.builder(
                        itemCount: categoriList.length,
                        itemBuilder: (context, index) {
                          return GeneralList(
                            titleLead: categoriList[index].category,
                            imageLead: categoriList[index].categoryImage,
                          );
                        })),
              ),
      ),
    );
  }
}
