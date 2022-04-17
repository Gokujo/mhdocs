# MyStatus - Статус сериалов

**Ссылка на разработку**: [<i class="fa-thin fa-paperclip"></i> Перейти к разработке](https://devcraft.club/downloads/mystatus.5/)

**Версия модификации**: <i class="fa-duotone fa-code-branch"></i> 1.0.2.3


## Установка

- Залить файлы из папки uploads в корень сайт
- Запустите файл **install.php** в корне вашего сайта, а затем удалите
- В шаблонах откройте файл **fullstory.tpl** и пропишите в самом низу файла

```html
{include file="engine/modules/mystatus.php?mysid={myshows}&title={title}&news_id={news-id}"}
```

В нужное место ставим

```html
<div class="status {statuss}">{status}</div>
```

- Открываем **engine/inc/addnews.php** и ищем

```php
<div class="form-group">
<label class="control-label col-md-2">{$lang['addnews_cat']}</label>
<div class="col-md-10">
<select data-placeholder="{$lang['addnews_cat_sel']}" name="category[]" id="category" onchange="onCategoryChange(this)" $category_multiple style="width:100%;max-width:350px;">{$categories_list}</select>
</div>
</div>
```

ниже добавляем

```html
<div class="form-group">
<label class="control-label col-md-2">MyShows ID</label>
<div class="col-md-10">
<input type="text" name="myshows" size="20" >
</div>
</div>
```

находим

```php
$disable_index = isset( $_POST['disable_index'] ) ? intval( $_POST['disable_index'] ) : 0;
```

ниже ставим

```php
$myshowsid = intval($_POST['myshows']);
```

находим

```php
tags, metatitle
```

после ставим

```php
, myshowsid
```

находим

```php
'{$_POST['tags']}', '{$metatags['title']}'
```

после ставим

```php
, '$myshowsid'
```

- Открываем **engine/inc/editnews.php** и ищем

```php
<div class="form-group">
<label class="control-label col-md-2">{$lang['edit_cat']}</label>
<div class="col-md-10">
<select data-placeholder="{$lang['addnews_cat_sel']}" name="category[]" id="category" onchange="onCategoryChange(this)" {$category_multiple} style="width:350px;">{$categories_list}</select>
</div>
</div>
```

ниже добавляем

```php
<div class="form-group">
<label class="control-label col-md-2">MyShows ID</label>
<div class="col-md-10">
<input type="text" name="myshows" size="20" value="{$row['myshowsid']}">
</div>
</div>
```

находим

```php
$disable_index = isset( $_POST['disable_index'] ) ? intval( $_POST['disable_index'] ) : 0;
ниже ставим
[CODE=php]$myshowsid = intval($_POST['myshows']);
```

находим (дважды)

```php
metatitle='{$metatags['title']}'
```

после ставим (дважды)

```php
, myshowsid='{$myshowsid}'
```

- Открываем файл **engine/modules/show.full.php** и находим

```php
if ($row['metatitle']) $metatags['header_title'] = $row['metatitle'];
```

Ниже прописываем

```php
include ENGINE_DIR . "/data/mystatus.php";
$xfieldsdata = xfieldsdataload( $row['xfields'] );
$tpl->set("{myshows}", $row['myshowsid']);
//Определяем статус и выводим его
$xfieldsdata[$mystatus_cfg['xfield']] = trim( $xfieldsdata[$mystatus_cfg['xfield']] );
if($xfieldsdata[$mystatus_cfg['xfield']] == "canceledended") {
$statusname = $mystatus_cfg['closed'];
} elseif($xfieldsdata[$mystatus_cfg['xfield']] == "returningseries") {
$statusname = $mystatus_cfg['onair'];
} elseif($xfieldsdata[$mystatus_cfg['xfield']] == "tbdothebubble") {
$statusname = $mystatus_cfg['tbd'];
} elseif($xfieldsdata[$mystatus_cfg['xfield']] == "onhiatus") {
$statusname = $mystatus_cfg['pause'];
} elseif($mystatus_cfg['pilots'] && $xfieldsdata[$mystatus_cfg['xfield']] == "pilotordered") {
$statusname = $mystatus_cfg['pilot'];
} elseif($mystatus_cfg['news'] && $xfieldsdata[$mystatus_cfg['xfield']] == "newseries") {
$statusname = $mystatus_cfg['new'];
} else {
$statusname = $mystatus_cfg['none'];
}
$tpl->set( '{statuss}', $xfieldsdata[$mystatus_cfg['xfield']] );
$tpl->set( '{status}', $statusname );
```

- Открываем файл **engine/modules/show.short.php**, **engine/modules/show.custom.php** (если хотим, чтобы статус отображался и короткой новости или в построенной через кастом) и находим 2ой

```php
$tpl->compile( 'content' );
}
if( $user_group[$member_id['user_group']]['allow_hide'] ) $tpl->result['content'] = str_ireplace( "[hide]", "", str_ireplace( "[/hide]", "", $tpl->result['content']) );
```

Выше прописываем

```php
include ENGINE_DIR . "/data/mystatus.php";
$xfieldsdata = xfieldsdataload( $row['xfields'] );
$tpl->set("{myshows}", $row['myshowsid']);
//Определяем статус и выводим его
$xfieldsdata[$mystatus_cfg['xfield']] = trim( $xfieldsdata[$mystatus_cfg['xfield']] );
if($xfieldsdata[$mystatus_cfg['xfield']] == "canceledended") {
$statusname = $mystatus_cfg['closed'];
} elseif($xfieldsdata[$mystatus_cfg['xfield']] == "returningseries") {
$statusname = $mystatus_cfg['onair'];
} elseif($xfieldsdata[$mystatus_cfg['xfield']] == "tbdothebubble") {
$statusname = $mystatus_cfg['tbd'];
} elseif($xfieldsdata[$mystatus_cfg['xfield']] == "onhiatus") {
$statusname = $mystatus_cfg['pause'];
} elseif($mystatus_cfg['pilots'] && $xfieldsdata[$mystatus_cfg['xfield']] == "pilotordered") {
$statusname = $mystatus_cfg['pilot'];
} elseif($mystatus_cfg['news'] && $xfieldsdata[$mystatus_cfg['xfield']] == "newseries") {
$statusname = $mystatus_cfg['new'];
} else {
$statusname = $mystatus_cfg['none'];
}
$tpl->set( '{statuss}', $xfieldsdata[$mystatus_cfg['xfield']] );
$tpl->set( '{status}', $statusname );
```

- В нужное место в **shortstory.tpl** или в шаблон, что подключён через кастом, ставим

```html
<div class="status {statuss}">{status}</div>
```

- Открываем файл со стилями шаблона и в самый низ прописываем это

```css


.status, .status.normal {
    float: right;
    margin-top: -35px;
    font-style: normal;
    opacity: 0.6;
    color: #000;
    transition: all 0.3s;
    font-weight: 700;
}

.status:hover {
    opacity: 1;
    cursor: pointer;
    animation: shake linear 0.5s;
    animation-iteration-count: 1;
    transform-origin: 50% 0%;
    -webkit-animation: shake linear 0.5s;
    -webkit-animation-iteration-count: 1;
    -webkit-transform-origin: 50% 0%;
    -moz-animation: shake linear 0.5s;
    -moz-animation-iteration-count: 1;
    -moz-transform-origin: 50% 0%;
    -o-animation: shake linear 0.5s;
    -o-animation-iteration-count: 1;
    -o-transform-origin: 50% 0%;
    -ms-animation: shake linear 0.5s;
    -ms-animation-iteration-count: 1;
    -ms-transform-origin: 50% 0%;
}

.status.returningseries {
    color: #ebffdd;
    text-shadow: 0 0 1px black, 0 0 2px #5cad21, 0 0 3px #549e1e, 0 0 4px #3d8806;
}

.status.canceledended {
    color: #ffd4d4;
    text-shadow: 0 0 1px black, 0 0 2px #ff0000, 0 0 3px #bf2727, 0 0 4px #792323;
}

.status.onhiatus {
    color: #ffecbf;
    text-shadow: 0 0 1px black, 0 0 2px #ffb300, 0 0 3px #cc971a, 0 0 4px #daa321;
}

.status.tbdonthebubble {
    color: #e8faff;
    text-shadow: 0 0 1px black, 0 0 2px #1bc1ff, 0 0 3px #4ae7ea, 0 0 4px #277890;
}

.status.pilotordered {
    color: #e0ebff;
    text-shadow: 0 0 1px black, 0 0 2px #0058ff, 0 0 3px #275dc5, 0 0 4px #93aee0;
}

.status.newseries {
    color: #fae2ff;
    text-shadow: 0 0 1px black, 0 0 2px #d600ff, 0 0 3px #89319a, 0 0 4px #631a71;
}

@keyframes shake {
    0% {
        transform: rotate(0deg);
    }
    20% {
        transform: rotate(15deg);
    }
    40% {
        transform: rotate(-10deg);
    }
    60% {
        transform: rotate(5deg);
    }
    80% {
        transform: rotate(-5deg);
    }
    100% {
        transform: rotate(0deg);
    }
}

@-moz-keyframes shake {
    0% {
        -moz-transform: rotate(0deg);
    }
    20% {
        -moz-transform: rotate(15deg);
    }
    40% {
        -moz-transform: rotate(-10deg);
    }
    60% {
        -moz-transform: rotate(5deg);
    }
    80% {
        -moz-transform: rotate(-5deg);
    }
    100% {
        -moz-transform: rotate(0deg);
    }
}

@-webkit-keyframes shake {
    0% {
        -webkit-transform: rotate(0deg);
    }
    20% {
        -webkit-transform: rotate(15deg);
    }
    40% {
        -webkit-transform: rotate(-10deg);
    }
    60% {
        -webkit-transform: rotate(5deg);
    }
    80% {
        -webkit-transform: rotate(-5deg);
    }
    100% {
        -webkit-transform: rotate(0deg);
    }
}

@-o-keyframes shake {
    0% {
        -o-transform: rotate(0deg);
    }
    20% {
        -o-transform: rotate(15deg);
    }
    40% {
        -o-transform: rotate(-10deg);
    }
    60% {
        -o-transform: rotate(5deg);
    }
    80% {
        -o-transform: rotate(-5deg);
    }
    100% {
        -o-transform: rotate(0deg);
    }
}

@-ms-keyframes shake {
    0% {
        -ms-transform: rotate(0deg);
    }
    20% {
        -ms-transform: rotate(15deg);
    }
    40% {
        -ms-transform: rotate(-10deg);
    }
    60% {
        -ms-transform: rotate(5deg);
    }
    80% {
        -ms-transform: rotate(-5deg);
    }
    100% {
        -ms-transform: rotate(0deg);
    }
}

@-o-keyframes animationFrames {
    0% {
        -o-transform: rotate(0deg);
    }
    20% {
        -o-transform: rotate(15deg);
    }
    40% {
        -o-transform: rotate(-10deg);
    }
    60% {
        -o-transform: rotate(5deg);
    }
    80% {
        -o-transform: rotate(-5deg);
    }
    100% {
        -o-transform: rotate(0deg);
    }
}

@-ms-keyframes animationFrames {
    0% {
        -ms-transform: rotate(0deg);
    }
    20% {
        -ms-transform: rotate(15deg);
    }
    40% {
        -ms-transform: rotate(-10deg);
    }
    60% {
        -ms-transform: rotate(5deg);
    }
    80% {
        -ms-transform: rotate(-5deg);
    }
    100% {
        -ms-transform: rotate(0deg);
    }
}
```

- Создаём доп. поле
**Название поля**, **Описание поля** и **Категория** на своё усмотрение
**Тип поля**: Список
**Значение по умолчанию**:
Для DLE 11 и выше можно сделать так

```
returningseries|Снимаетсяnewseries|Новинка
pilotordered|Пилотная серия
canceledended|Закрыт
onhiatus|Приостановлен
tbdonthebubble|Под вопросом
```

Для версий ниже поля должны выглядеть так

```
returningseriesnewseries
pilotordered
canceledended
onhiatus
tbdonthebubble
```

## Пример подключения
```HTML
{include file="engine/modules/mystatus.php?mysid={myshows}&title={title}&news_id={news-id}"}
```

- **mysid** - это поле нужно для выяснения ID с MyShows
- **title** - к этому тегу подключается любая комбинация названия. Желательно иметь такую комбинацию: Русское название English Name (ГОД)
- **news_id** - это определяющее самой новости


!!! warning "Внимание!"
	Не будет работать, если подключать доп. поля в режиме перелинковки. Для этого нужно создавать и/ли определять доп. поля по новой

## Доп. поля как перекрёстные ссылки

Если у вас подключены доп. поля как перекрёстные ссылки и вы не можете обойтись без них, то делаем следующее

Открываем **/engine/modules/show.full.php** и ищем


```php
$tpl->set( '{statuss}', $xfieldsdata[$mystatus_cfg['xfield']] );
```

и выше или ниже ставим


```php
if($xfieldsdata['НАЗВАНИЕ_ДОП_ПОЛЯ'] != "" || !empty($xfieldsdata['НАЗВАНИЕ_ДОП_ПОЛЯ'])) {
    $ОПРЕДЕЛИТЕЛЬНОЕ_НАЗВАНИЕ = $xfieldsdata['НАЗВАНИЕ_ДОП_ПОЛЯ']
} else {
    $ОПРЕДЕЛИТЕЛЬНОЕ_НАЗВАНИЕ = "";
}

$tpl->set( '{НАЗВАНИЕ}', $ОПРЕДЕЛИТЕЛЬНОЕ_НАЗВАНИЕ );
```

После этого в конструкцию подключения добавляем **{НАЗВАНИЕ}**

Названия все на латинском!

## Установка на 13.х
Для этого достаточно установить архив из папки 13.х, залить файлы и папки engine и templates из папки 12.х в корень сайта и проследовать установке начиная с пункта шаблонов.