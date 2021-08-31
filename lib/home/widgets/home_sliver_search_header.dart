import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mealbook/common/ui/app_colors.dart';

class HomeSliverSearchHeader extends SliverPersistentHeaderDelegate {
  const HomeSliverSearchHeader({
    required String queryText,
    required void Function() onTapSearch,
    required void Function() onTapClear,
  })  : _queryText = queryText,
        _onTapSearch = onTapSearch,
        _onTapClear = onTapClear;

  final String _queryText;
  final void Function() _onTapSearch;
  final void Function() _onTapClear;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double shrinkPercentage = min(
      1,
      shrinkOffset / (maxExtent - minExtent),
    );

    return Material(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Opacity(
                opacity: shrinkPercentage == 1
                    ? 0
                    : pow(2, -10 * shrinkPercentage).toDouble(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: FittedBox(
                    child: Text(
                      'Find Best Recipe\nFor Cooking',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Hero(
              tag: 'search-field',
              child: SizedBox(
                height: 64,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.primary,
                  child: InkWell(
                    onTap: _onTapSearch,
                    borderRadius: BorderRadius.circular(24),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 8),
                          child: Icon(
                            Icons.search,
                            color: AppColors.textFaded,
                            size: 36,
                          ),
                        ),
                        Text(
                          _queryText.isNotEmpty
                              ? _queryText
                              : 'Search Destination',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textFaded,
                          ),
                        ),
                        const Spacer(),
                        if (_queryText.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            child: IconButton(
                              onPressed: _onTapClear,
                              icon: const Icon(
                                Icons.close,
                                color: AppColors.accent,
                                size: 36,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 180;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
