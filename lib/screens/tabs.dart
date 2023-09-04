import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/drawrer.dart';

Map<Filters, bool> kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  void _showSnackBar(String content) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    if (favoriteMeals.contains(meal)) {
      setState(() {
        favoriteMeals.remove(meal);
        _showSnackBar('This item is no longer a favorite.');
      });
    } else {
      setState(() {
        favoriteMeals.add(meal);
        _showSnackBar('Added to favorite.');
      });
    }
  }

  int _screenIndex = 0;

  void _selectPage(int index) {
    setState(() {
      if (index == 0) {
        _screenIndex = index;
      } else {
        _screenIndex = index;
      }
    });
  }

  final List<Meal> favoriteMeals = [];
  Map<Filters, bool> _selectedFilters = kInitialFilters;

  @override
  Widget build(BuildContext context) {
    var avilableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget? selectedScreen;
    if (_screenIndex == 0) {
      selectedScreen = CategoriesScreen(
        avilableMeals: avilableMeals,
        toggleMealFavoraiteStatus: _toggleMealFavoriteStatus,
      );
    } else {
      selectedScreen = MealsScreen(
        toggleMealFavoraiteStatus: _toggleMealFavoriteStatus,
        meals: favoriteMeals,
      );
    }

    void onSelectDrawer(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        final results = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(
            builder: (context) =>
                FiltersScreen(applyedFilters: _selectedFilters),
          ),
        );
        setState(() {
          _selectedFilters = results ?? kInitialFilters;
        });
      }
    }

    return Scaffold(
      drawer: MainDrawrer(
        onSelect: onSelectDrawer,
      ),
      appBar: AppBar(
          title: _screenIndex == 0
              ? const Text('Categories')
              : const Text('Favorites')),
      body: selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _selectPage(index),
        currentIndex: _screenIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
