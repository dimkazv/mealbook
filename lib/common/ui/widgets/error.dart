import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Icon(
          Icons.error_outline,
          size: 64,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Sorry, an error occurred :(',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
