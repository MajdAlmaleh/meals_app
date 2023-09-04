import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_list_item.dart';
import 'meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      required this.meals,
      this.title,
      required this.toggleMealFavoraiteStatus});
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) toggleMealFavoraiteStatus;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          toggleMealFavoraiteStatus: toggleMealFavoraiteStatus,
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return title == null
        ? meals.isEmpty
            ? const Center(
                child: Text(
                  'Nothing to see here yet!',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )
            : ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) => MealsListItem(
                  meal: meals[index],
                  onSelectMeal: () {
                    _selectMeal(context, meals[index]);
                  },
                ),
              )
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: meals.isEmpty
                ? const Center(
                    child: Text(
                      'Nothing to see here yet!',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )
                : ListView.builder(
                    itemCount: meals.length,
                    itemBuilder: (context, index) => MealsListItem(
                          meal: meals[index],
                          onSelectMeal: () {
                            _selectMeal(context, meals[index]);
                          },
                        )),
          );
  }
}
