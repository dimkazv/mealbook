# Запуск приложения
  
К примеру у нас три окружения: dev, stage и production. Тогда файловая структура должна быть следующая:  

**Production - main.dart**

Запуск:   
```bash  
flutter run -t lib/main.dart  
```  
**Stage - main_stage.dart**

Запуск:   
```bash  
flutter run -t lib/main_stage.dart  
```  
  
**Dev - main_dev.dart**

Запуск:   
```bash  
flutter run -t lib/main_dev.dart  
```  
  
**Важно:**
Каждый файл должен включать в себя конфигурацию специфичную для окружения. Допускается ее объявление только в этих файлах.