class RecipeType {
  static String? typeByIndex(int index) => index != 0 ? _types[index] : null;

  static String nameByIndex(int index) => _types[index];

  static int get lenght => _types.length;

  static const _types = [
    'Any',
    'Beef',
    'Breakfast',
    'Chicken',
    'Dessert',
    'Pasta',
    'Seafood',
    'Starter',
    'Vegan',
    'Miscellaneous',
    'Pork',
    'Goat',
    'Lamb',
    'Side',
  ];
}
