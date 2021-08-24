import 'package:template_bloc/common/env/build_types.dart';
import 'package:template_bloc/common/env/config.dart';
import 'package:template_bloc/common/env/debug_options.dart';
import 'package:template_bloc/common/env/environment.dart';
import 'package:template_bloc/common/logger/dev_logger.dart';
import 'package:template_bloc/common/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.stage,
    config: Config(
      logger: DevLogger(),
      title: 'ENV Flutter application template with Bloc state manager',
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
