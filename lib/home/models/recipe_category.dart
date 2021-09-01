enum RecipeCategoryEnum {
  any,
  beef,
  breakfast,
  chicken,
  dessert,
  pasta,
  seafood,
  starter,
  vegan,
  miscellaneous,
  pork,
  goat,
  lamb,
  side,
}

class RecipeCategoryHelper {
  static String getName(RecipeCategoryEnum category) =>
      _categoriesNames[category]!;

  static const _categoriesNames = {
    RecipeCategoryEnum.any: 'Any',
    RecipeCategoryEnum.beef: 'Beef',
    RecipeCategoryEnum.breakfast: 'Breakfast',
    RecipeCategoryEnum.chicken: 'Chicken',
    RecipeCategoryEnum.dessert: 'Dessert',
    RecipeCategoryEnum.pasta: 'Pasta',
    RecipeCategoryEnum.seafood: 'Seafood',
    RecipeCategoryEnum.starter: 'Starter',
    RecipeCategoryEnum.vegan: 'Vegan',
    RecipeCategoryEnum.miscellaneous: 'Miscellaneous',
    RecipeCategoryEnum.pork: 'Pork',
    RecipeCategoryEnum.goat: 'Goat',
    RecipeCategoryEnum.lamb: 'Lamb',
    RecipeCategoryEnum.side: 'Side',
  };
}
