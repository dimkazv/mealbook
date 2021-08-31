import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_state.dart';
import 'package:mealbook/common/error_listener.dart';
import 'package:mealbook/common/routes.dart';
import 'package:mealbook/common/ui/app_colors.dart';
import 'package:mealbook/common/ui/widgets/custom_radio_button.dart';
import 'package:mealbook/common/ui/widgets/error.dart';
import 'package:mealbook/common/ui/widgets/recipe_card.dart';
import 'package:mealbook/home/bloc/home_bloc.dart';
import 'package:mealbook/home/bloc/home_event.dart';
import 'package:mealbook/home/bloc/home_state.dart';
import 'package:mealbook/home/models/recipe_type.dart';
import 'package:mealbook/home/widgets/sliver_delegate.dart';
import 'package:mealbook/home/widgets/home_sliver_search_header.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _errorListener = ErrorListener();

  void _onTapRadioButton(BuildContext context, {required int typeIndex}) {
    context.read<HomeBloc>().add(HomeEventSetCategory(typeIndex: typeIndex));
  }

  void _onTapRecipe(BuildContext context, {required int id}) {
    Navigator.pushNamed(context, Routes.recipeDetailed, arguments: id);
  }

  Future<void> _onTapSearch(
    BuildContext context, {
    required String query,
  }) async {
    final result = await Navigator.pushNamed(
      context,
      Routes.search,
      arguments: query,
    );
    if ((result as String?) != null) {
      context.read<HomeBloc>().add(HomeEventSetQuery(query: result!));
    }
  }

  Future<void> _onTapClear(BuildContext context) async {
    context.read<HomeBloc>().add(const HomeEventSetQuery(query: ''));
  }

  Widget _body(BuildContext context, HomeState state) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HomeSliverSearchHeader(
              queryText: state.currentQuery,
              onTapSearch: () => _onTapSearch(
                context,
                query: state.currentQuery,
              ),
              onTapClear: () => _onTapClear(context),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            sliver: SliverPersistentHeader(
              floating: true,
              delegate: SliverDelegate(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: RecipeType.lenght,
                  itemBuilder: (context, index) => CustomRadioButton(
                    leading: RecipeType.nameByIndex(index),
                    value: index,
                    groupValue: state.currentType,
                    onChanged: (value) => _onTapRadioButton(
                      context,
                      typeIndex: index,
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                ),
              ),
            ),
          ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: RecipeCard(
                        title: state.recipes![index].title,
                        image: state.recipes![index].imageUrl,
                        onTap: () => _onTapRecipe(
                          context,
                          id: state.recipes![index].id,
                        ),
                      ),
                    );
                  },
                  childCount: state.recipes!.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loader() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 24, 32, 0),
                  child: Text(
                    'Find Best Recipe\nFor Cooking',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.shimmerContainer,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 64,
                          width: 124,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.shimmerContainer,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 64,
                          width: 124,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.shimmerContainer,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 64,
                          width: 124,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.shimmerContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: AppColors.shimmerContainer,
                      ),
                    ),
                    Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: AppColors.shimmerContainer,
                      ),
                    ),
                  ],
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
    return BlocListener<ErrorHandlerBloc, ErrorHandlerState>(
      listener: _errorListener.listener,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStateStatus.update) {
              return _body(context, state);
            }
            if (state.status == HomeStateStatus.error) {
              return const Error();
            }
            return _loader();
          },
        ),
      ),
    );
  }
}
