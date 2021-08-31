import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealbook/common/helpers/ingredient_image_helper.dart';
import 'package:mealbook/common/ui/app_colors.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_bloc.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_state.dart';
import 'package:mealbook/common/ui/widgets/error.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_tools/sliver_tools.dart';

class RecipeDetailedPage extends StatelessWidget {
  const RecipeDetailedPage({Key? key}) : super(key: key);

  Widget _appBar(
    BuildContext context, {
    required String title,
    required String imageUrl,
  }) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      pinned: true,
      expandedHeight: 388,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.action,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 16,
            left: 36,
            right: 36,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _ingredients({
    required List<String> ingredients,
    required List<String> measures,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
      sliver: MultiSliver(
        pushPinnedChildren: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Ingredients (${ingredients.length})',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.ingredientCard,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: AppColors.primary,
                        height: 64,
                        width: 64,
                        child: CachedNetworkImage(
                          imageUrl: IngredientImageHelper.getUrlByName(
                            ingredients[index],
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                ingredients[index],
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                measures[index],
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: AppColors.textFaded,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              childCount: ingredients.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _instruction({required String instructions}) {
    return SliverSafeArea(
      sliver: SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        sliver: MultiSliver(
          children: [
            const Text(
              'Instruction',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                instructions,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loader() {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.shimmerContainer,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(36, 8, 36, 0),
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.shimmerContainer,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 40, 24, 16),
                height: 32,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.shimmerContainer,
                ),
              ),
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.shimmerContainer,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
              ),
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.shimmerContainer,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
              ),
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.shimmerContainer,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecipeDetailedBloc, RecipeDetailedState>(
        builder: (context, state) {
          if (state.status == RecipeDetailedStateStatus.update) {
            return CustomScrollView(
              slivers: [
                _appBar(
                  context,
                  title: state.mealUi!.title,
                  imageUrl: state.mealUi!.imageUrl,
                ),
                _ingredients(
                  ingredients: state.mealUi!.ingredients!,
                  measures: state.mealUi!.measures!,
                ),
                _instruction(instructions: state.mealUi!.instructions!),
              ],
            );
          }
          if (state.status == RecipeDetailedStateStatus.error) {
            return const Error();
          }
          return _loader();
        },
      ),
    );
  }
}
