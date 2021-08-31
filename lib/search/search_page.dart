import 'package:flutter/material.dart';
import 'package:mealbook/common/ui/app_colors.dart';

class SearchPage extends StatelessWidget {
  SearchPage({required String query, Key? key})
      : _controller = TextEditingController(text: query),
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Hero(
            tag: 'search-field',
            child: SizedBox(
              height: 64,
              child: Material(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        onSubmitted: (value) =>
                            Navigator.of(context).pop(value),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          Navigator.of(context).pop(_controller.text),
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
