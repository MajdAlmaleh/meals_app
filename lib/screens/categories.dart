import 'package:meals_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/categories_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.toggleMealFavoraiteStatus,
      required this.avilableMeals});
  final void Function(Meal meal) toggleMealFavoraiteStatus;
  final List<Meal> avilableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final selectedMeals = (avilableMeals
        .where((meal) => meal.categories.contains(category.id))).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
            meals: selectedMeals,
            title: category.title,
            toggleMealFavoraiteStatus: toggleMealFavoraiteStatus),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(4),
      //physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: availableCategories
          .map((category) => CategoryGridItem(
                category: category,
                onSelectedCategory: () {
                  _selectCategory(context, category);
                },
              ))
          .toList(),
    );
  }
}
