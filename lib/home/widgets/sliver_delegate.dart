import 'package:flutter/material.dart';

class SliverDelegate extends SliverPersistentHeaderDelegate {
  const SliverDelegate({required Widget child}) : _child = child;

  final Widget _child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: Center(child: _child),
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
