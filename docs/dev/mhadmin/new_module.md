# Генератор модуля

Данный функционал был разработан для облегчённого добавления структуры разработки административной панели плагина.

## Форма добавления

![image.png](assets/image.png)


## Структура файлов

Скрипт создаёт ряд папок и файлов

**Папки**:

```php
ROOT_DIR . '/engine/ajax/maharder/' . $data['translit'],
ROOT_DIR . '/engine/inc/maharder/' . $data['translit'],
ROOT_DIR . '/engine/inc/maharder/admin/modules/' . $data['translit'],
ROOT_DIR . '/engine/inc/maharder/admin/assets/img/' . $data['translit'],
ROOT_DIR . '/engine/inc/maharder/admin/templates/modules/' . $data['translit'],
```

**Файлы**:

```php
ROOT_DIR . '/engine/ajax/maharder/' . $data['translit'] . '/master.php',
ROOT_DIR . '/engine/inc/' . $data['translit'] . '.php',
ROOT_DIR . '/engine/inc/maharder/admin/modules/' . $data['translit'] . '/main.php',
ROOT_DIR . '/engine/inc/maharder/admin/templates/modules/' . $data['translit'] . '/main.html',
```

## Возможные ошибки

1. При создании плагина плагин может произойти асечка, которая не даст добавить плагин в базу данных. Поэтому надо будет его добавить повторно, либо ручками
2. Проверяйте структуру файлов после генерации
3. Форматирования SQL кода в плагине может не соответвовать нужным параметрам, поэтому плагин будет выбрасывать ошибки - просто пересохраните плагин
