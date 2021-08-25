import 'package:mealbook/common/env/build_types.dart';
import 'package:mealbook/common/env/config.dart';
import 'package:mealbook/common/env/debug_options.dart';
import 'package:mealbook/common/env/environment.dart';
import 'package:mealbook/common/logger/production_logger.dart';
import 'package:mealbook/common/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.release,
    config: Config(
      logger: ProductionLogger(),
      title: 'ENV Flutter application template with Bloc state manager',
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
