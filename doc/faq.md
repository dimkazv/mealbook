# Ответы на вопросы (FAQ)  
  
#### 1. Изменение Package Name
  
```bash  
flutter pub run change_app_package_name:main com.new_package_name  
```  
  
Где com.new_package_name это новый Package Name  
  
#### 2. Изменение name в pubspec.yaml
  
Документация - https://dart.dev/tools/pub/pubspec#name  
  
Как это сделать в Mac OS / Linux  
  
```bash  
sed -i "" "s/template_bloc/new_name/g" pubspec.yaml  
find . -name '*.dart' -print0 | xargs -0 sed -i "" "s/template_bloc/new_name/g"  
```  
  
Где new_name новое название, template_bloc старое название.  
Данные команды изменят name в pubspec.yaml и обновят импорт!  
  
#### 3. Локализация
  
Все интересные моменты можно подчерпнуть в оф документации - https://flutter.dev/docs/development/accessibility-and-localization/internationalization  
  
  
#### 4. Пример использования NoAnimationRoute

Позволяет переходить на указанные экраны без анимации. Для использования необходимо иметь два роута для одного экрана - обычный и с постфиксом "non_animated", и добавить кейс в метод getGeneratedRoutes().   

Пример использования:

```dart  
case Routes.exampleNonAnimated:
    return NoAnimationRoute<dynamic>(
        settings: settings,
        builder: (context) => _routes[Routes.example](context),
    );
    break;
```
