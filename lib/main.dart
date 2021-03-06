import 'package:mealbook/common/env/build_types.dart';
import 'package:mealbook/common/env/config.dart';
import 'package:mealbook/common/env/debug_options.dart';
import 'package:mealbook/common/env/environment.dart';
import 'package:mealbook/common/logger/production_logger.dart';
import 'package:mealbook/common/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.production,
    config: Config(
      logger: ProductionLogger(),
      debugOptions: DebugOptions(),
      apiBaseUrl: 'https://www.themealdb.com/api/json/v1/1/',
    ),
  );

  run();
}
