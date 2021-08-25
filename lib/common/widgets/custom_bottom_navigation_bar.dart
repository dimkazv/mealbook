import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template_bloc/common/routes.dart';
import 'package:template_bloc/common/ui/app_assets.dart';
import 'package:template_bloc/common/ui/app_colors.dart';

enum CustomBottomBarSelectedPage { home, favorites, shoppingList }

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required CustomBottomBarSelectedPage selectedPage,
    Key? key,
  })  : _selectedPage = selectedPage,
        super(key: key);

  final CustomBottomBarSelectedPage _selectedPage;

  void _onTapHome(BuildContext context) {
    if (_selectedPage != CustomBottomBarSelectedPage.home) {
      Navigator.of(context).pushNamed(
        Routes.home,
      );
      return;
    }
  }

  void _onTapHistory(BuildContext context) {
    if (_selectedPage != CustomBottomBarSelectedPage.favorites) {
      // Navigator.of(context).pushNamed(
      //   Routes.ownerHistoryNonAnimated,
      // );
      return;
    }
  }

  void _onTapProfile(BuildContext context) {
    if (_selectedPage != CustomBottomBarSelectedPage.shoppingList) {
      // Navigator.of(context).pushNamed(
      //   Routes.ownerProfileNonAnimated,
      // );
      return;
    }
  }

  Widget _button({
    required BuildContext context,
    required String assetName,
    required void Function() onTap,
    bool selected = false,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: 64,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: SvgPicture.asset(
                assetName,
                color: selected
                    ? AppColors.bottomBarIconSelected
                    : AppColors.bottomBarIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.bottomBarShadow.withOpacity(0.3),
            blurRadius: 10,
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 1,
          ),
        ],
      ),
      child: BottomAppBar(
        color: AppColors.primary,
        child: Row(
          children: <Widget>[
            _button(
              context: context,
              assetName: AppAssets.homeIcon,
              onTap: () => _onTapHome(context),
              selected: _selectedPage == CustomBottomBarSelectedPage.home,
            ),
            _button(
              context: context,
              assetName: AppAssets.favoriteIcon,
              onTap: () => _onTapHistory(context),
              selected: _selectedPage == CustomBottomBarSelectedPage.favorites,
            ),
            _button(
              context: context,
              assetName: AppAssets.shoppingListIcon,
              onTap: () => _onTapProfile(context),
              selected:
                  _selectedPage == CustomBottomBarSelectedPage.shoppingList,
            ),
          ],
        ),
      ),
    );
  }
}
