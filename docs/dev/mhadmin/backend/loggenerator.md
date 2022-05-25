***

# LogGenerator

Вспомогательный класс для создания лог данных. 

## Метод подключения

```php
include_once DLEPlugins::Check(ENGINE_DIR . '/inc/maharder/_includes/trait/LogGenerator.php');
```


## Свойства

### logs

Регулятор логирования системы

```php
protected int $logs
```

***

## Методы

### generate_log

Генерация лог-файлов, если по какой-то причине произошла ошибка во время исполнения функционала

```php
public generate_log(string $service, string $function_name, mixed $message, string $type = "error"): void
```

**Параметры:**

| Параметр | Тип       | Описание                                                                               |
|-----------|------------|-------------------------------------------------------------------------------------------|
| `$service` | **string** | Название класса / модели                                                                  |
| `$function_name` | **string** | Название функции                                                                          |
| `$message` | **mixed**  | Сообщение для лога, может быть строкой, а может быть и массивом                           |
| `$type` | **string**      | Тип лога, по умолчанию: error. Возможно: error, info, notice, warning, critical, alert, debug |

***

### getLogs

Возвращает состояние регулятора 

```php
public getLogs(): bool
```

***

### setLogs

```php
public setLogs(bool|int $logs): void
```

**Параметры:**

| Параметр | Тип | Описание                                               |
|-----------|------|--------------------------------------------------------|
| `$logs` | **bool&#124;int** | Принимает статус регулятора, либо true/false, либо 1/0 |


***
