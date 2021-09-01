import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealbook/common/env/build_types.dart';
import 'package:mealbook/common/env/config.dart';
import 'package:mealbook/common/env/debug_options.dart';
import 'package:mealbook/common/env/environment.dart';
import 'package:mealbook/common/logger/dev_logger.dart';
import 'package:mealbook/common/runner.dart';
import 'package:mealbook/common/debug_bloc_observer.dart';

void main() {
  Bloc.observer = DebugBlocObserver();

  Environment.init(
    buildType: BuildType.dev,
    config: Config(
      logger: DevLogger(),
      debugOptions: DebugOptions(),
      apiBaseUrl: 'https://www.themealdb.com/api/json/v1/1/',
    ),
  );

  run();
}
