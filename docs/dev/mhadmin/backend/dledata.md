***

# DleData

Набор функционала для работы с данными системы DLE 

## Метод подключения

```php
include_once DLEPlugins::Check(ENGINE_DIR . '/inc/maharder/_includes/trait/DleData.php');
```

## Методы

### get_used_xfields

Возвращает массив с использованными доп. полями в новости

```php
public get_used_xfields(int $id, string $type = "post"): array|false
```

**Параментры:**

| Параметр | Тип        | Описание                                    |
|-----------|------------|---------------------------------------------|
| `$id` | **int**      | ID объекта                                  |
| `$type` | **string** | Тип объекта, post или user. По умолчанию: post |

***

### loadXfields

Загружает все дополнительные поля для новостей и пользователей

```php
public loadXfields(string $type = "post"): array
```

**Параментры:**

| Параметр | Тип | Описание                                                                          |
|-----------|------|-----------------------------------------------------------------------------------|
| `$type` | **string** | Тип дополнительных полей, по умолчанию: post. Может принимать значения post или user |

***

### getUsers

Получаем список пользователей

```php
public getUsers(): array
```

***

### getCats

Получаем простой список категорий на сайте<br>
в виде массива с данными ID и названием

```php
public getCats(): array
```

***
