import 'package:flutter/material.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  Size get getScreenSize => MediaQuery.of(context).size;
}

class mealDetail {
  late String mealName;
  late String category;
  late String country;
  late String image;
  late String idMeal;
}

class categories {
  late String category;
  late String categoryImage;
}

class Country {
  late String country;
  late String countryImage;
}

class mealIngredients {
  String? ingredrient;
  String? quantity;
}

class mealDescription {
  String? mealName;
  String? mealCat;
  String? country;
  String? mealInstructions;
  String? mealImage;
  String? mealVedio;
}

BoxShadow kBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 2,
  blurRadius: 8,
  offset: Offset(0, 0),
);

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
