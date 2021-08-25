import 'package:flutter/material.dart';
import 'package:mealbook/common/ui/app_colors.dart';
import 'package:mealbook/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:mealbook/common/widgets/custom_radio_button.dart';
import 'package:mealbook/common/widgets/recipe_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Text(
                  'Find Best Recipe\nFor Cooking',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 24),
                child: SizedBox(
                  height: 64,
                  child: Material(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.primary,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(24),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            child: Icon(
                              Icons.search,
                              color: AppColors.textFaded,
                              size: 36,
                            ),
                          ),
                          Text(
                            'Search Destination',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textFaded,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) => CustomRadioButton(
                    leading: 'Radio$index',
                    value: index,
                    groupValue: 0,
                    onChanged: (value) {},
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ListView.separated(
                    itemCount: 5,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) => const RecipeCard(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedPage: CustomBottomBarSelectedPage.home,
      ),
    );
  }
}
