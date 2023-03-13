import 'package:chef_recipes/screens/ingredientPage.dart';
import 'package:chef_recipes/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Recipe extends StatelessWidget {
  const Recipe({
    Key? key,
    required this.categoriList,
    required this.sizeCard,
    required this.aspectRatio,
  }) : super(key: key);

  final double sizeCard;
  final double aspectRatio;
  final List<mealDetail> categoriList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * sizeCard,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                print(categoriList[index].idMeal);
                Navigator.push(
                  context,
                  CustomRoute(builder: (context) => IngredientPage(idMeal: categoriList[index].idMeal,)),
                );
              },
              child: AspectRatio(
                aspectRatio: aspectRatio / 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        categoriList[index].image,
                        fit: BoxFit.cover,
                      ),
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          "${categoriList[index].mealName}".toUpperCase(),
                          style: GoogleFonts.roboto(fontSize: 12)),
                    )
                  ],
                ),
              ),
            );
          }),
          separatorBuilder: (context, _) => const SizedBox(
                width: 0,
              ),
          itemCount: 5),
    );
  }
}
