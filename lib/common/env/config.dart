import 'package:mealbook/common/env/debug_options.dart';
import 'package:mealbook/common/logger/logger.dart';

class Config {
  Config({
    required this.logger,
    required this.debugOptions,
    required this.apiBaseUrl,
  });

  final Logger logger;
  final DebugOptions debugOptions;
  final String apiBaseUrl;
}
