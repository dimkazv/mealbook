# Окружение  
  
Все поля в окружение добавляются через новый конфиг или существующий. Пример конфига в шаблоне:  
  
```dart  
import 'package:template_bloc/common/env/debug_options.dart';  
import 'package:template_bloc/common/logger/logger.dart';  
  
class Config {  
  Config({  
    required this.logger,  
    required this.title,  
    required this.debugOptions,  
  });  
  
  final Logger logger;  
  final String title;  
  final DebugOptions debugOptions;  
}  
  
```  
  
Инициализация происходит в самом начале, в main с соответствующим env постфиксом.  
  
Пример:  
  
```dart  
Environment.init(  
  buildType: BuildType.dev,  
  config: Config(  
    logger: DevLogger(),  
    title: 'ENV Flutter application template with Bloc state manager',  
    debugOptions: DebugOptions(),  
  ),  
);
```  
  
Пример чтения из Env:  
  
*Доступно везде, так как Environment - Singleton.*  
  
```dart  
Environment<Config>.instance().config.title  
```