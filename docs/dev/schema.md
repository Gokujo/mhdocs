# SCHEMA.ORG

**Видеомикроразметка на DLE**

**Доп. поля**

Для начала, я советую просмотреть саму структуру построения: ** [Movie - schema.org](http://schema.org/Movie)**. Для себя я выбрал следующие поля:

- **contributor**или **countryOfOrigin**(лучше первое) - Страна
- **copyrightyear**- Год
- **genre**- Жанр (если у вас категории являются жанром, то пропускаем)
- **director**- Режиссёр creator - Сценарист
- **musicBy**- Композитор
- **editor**- Монтаж
- **producer**- Продюсер
- **provider**- Оператор
- **translator**- Перевод / озвучание
- **actor**- Актёры

!!! warning "Внимание!"
Нужно (!) создать следующие поля со следующими названиями (одно поле с функцией "Использовать при желании (можно оставить поле пуcтым)" и "Использовать значения полей как перекрестные гиперссылки ")!
Эти поля должны называться ИМЕННО ТАК! Никак иначе!!! Не обязательно использовать все поля, но если будете - то только такие! Однако, нам понадобятся другие поля. Поля для: ID с кинопоиска, постера, русского названия, оригинального названия, ссылки(!) для трейлера, ссылки для видео (покажу как реализовать вывод плеера на отдельной странице), продолжительности самого фильма (в формате ЧЧ:ММ:СС). Поле короткой и полной новости будет использовано для описания. На этой стадии вы должны определиться что вы хотите видеть у себя на сайте.

если у вас уже есть поля и вы захотите заменить на вышеупомянутые, то вам следует сначала сделать так.

1. идём в phpMyAdmin в таб SQL
2. выполняем запрос:

```sql
UPDATE `dle_post` SET `xfields`=REPLACE(`xfields`,'СтароеНазвание','НовоеНазвание');
```

3. открываем /engine/data/xfields.txt и меням поля
4. идём в админку в управление доп. полями
5. выбираем любое на редактирование и пересохраняем его
6. чистим кеш

## **Полная новость**

**(ваш-сайт.ру/templates/шаблон/fullstory.tpl)**

Начнём с простого. Создаём поля. Далее идём к шаблонам. **Открываем fullstory.tpl**. В самое начало ставим

```html
<div itemscope itemtype="http://schema.org/Movie">
<meta itemprop="dateCreated" content="{date=Y-m-d}">
    <meta itemprop="inLanguage" content="ru">
    <meta itemprop="isFamilyFriendly" content="[if xfvalue_age>=16]false[/if][if xfvalue_age<=15]True[/if]">
    [xfgiven_trailer]<link itemprop="trailer" value="[xfvalue_trailer]">[/xfgiven_trailer]
    [xfgiven_video]<link itemprop="video" value="{print-link}">[/xfgiven_video]
```

а в конец

```html
</div>
```

А тут

```html
<meta itemprop="isFamilyFriendly" content="[if xfvalue_age>=16]false[/if][if xfvalue_age<=15]True[/if]">
```

я использовал [это](http://shop.sandev.pro/post/19.html). Если вы не можете себе этого позволить или не хотите обновить движок, то меняем на это

```html
<meta itemprop="isFamilyFriendly" content="[catlist=X]false[/catlist][not-catlist=X]True[/not-catlist]">
```

**Х** меняем на ID категории, которая предназначена для "взрослых" (к.п. Жанр "Эротика"). А если и это вас не устраивает, то вот:

```html
<meta itemprop="isFamilyFriendly" content="True">
```

```html
[xfgiven_trailer]<link itemprop="trailer" value="[xfvalue_trailer]">[/xfgiven_trailer]
[xfgiven_video]<link itemprop="video" value="{print-link}">[/xfgiven_video]
```

- **trailer**- это название поля, куда вводится ссылка на трейлер. Меняем на своё.
- **video**- это название поля, куда вводится ссылка на видео. Меняем на своё.
- **{print-link}**- об этом ниже

Далее, желательно тег **{title}** обернуть ссылкой на новость, примерно так:

```html
<a itemprop="url" href="{full-link}">{title}</a>
```

**itemprop="url"** - этот тег нужен для разметки, который указывает на страницу записи.

Можно и так сделать, в самом начале документа после

```html
<div itemscope itemtype="http://schema.org/Movie">
```

добавляем

```html
<link itemprop="url" href="{full-link}">
```

Однако, при этом теряется описание ссылки, посему выбирать вам.

Далее. Прописываем доп. поля. Пример:
Русское название

```html
<span itemprop="name">[xfvalue_name]</span>
```

Оригинальное название

```html
<span itemprop="alternateName">[xfvalue_nameo]</span>
```

Продолжительность

```html
<span itemprop="duration">[xfvalue_time]</span>
```

ID с кинопоиска

```html
<noindex><a href="http://www.kinopoisk.ru/level/1/film/[xfvalue_kpid]/" target="_blank" itemprop="sameAs">Открыть на кинопоиске</a></noindex>
```

Постер

```html
<img itemprop="image" src="{image-1}" title="{title}">
```

Описание

```html
<div itemprop="description">{full-story}</div>
```

Поля меняем на свои

Дальше (опционально), если вы используете вывод кол-во комментариев, то оборачиваем **{comments-num}** в

```html
<span itemprop="commentCount">{comments-num}</span>
```

чтобы обработать рейтинг (рейтинг в звёзды!), делаем следующее

```html
<div itemprop="aggregateRating"
        itemscope itemtype="http://schema.org/AggregateRating">
        <link itemprop="itemReviewed" content="{full-link}">
                [rating]<div style="float:left;width:100px;">Рейтинг:</div>{rating}<div style="float:left;width:120px;">(голосов: {vote-num})</div>[/rating]
                 </div>
```

сделаем сразу разметку для видеофайла (рекомендуется трейлер). После

```html
<div itemscope itemtype="http://schema.org/Movie">
```

```html
<div itemprop="video" itemscope itemtype="http://schema.org/VideoObject">
        <link itemprop="thumbnail" href="{image-1}" />
        <img itemprop="thumbnailUrl" src="{image-1}" title="{title}" style="display:none;">
        <meta itemprop="description" content="{full-story}" />
        <meta itemprop="name" content="{title}" />
        <meta itemprop="uploadDate" content="{date=Y-m-d}T{date=G:i:s}" />
        <meta itemprop="datePublished" content="{date=Y-m-d}">
        <link itemprop="url" href="http://kinospace.org/play/{kp_id}/" />
        <meta itemprop="isFamilyFriendly" content="[if xfvalue_age>=16]false[/if][if xfvalue_age<=15]True[/if]">
        <meta itemprop="duration" content="[xfvalue_time]" />
    </div>
```

поясню:

- **{image-1}** - это постер
- **http://kinospace.org/play/{kp_id}/**- ссылка на видео файл или трейлер

меняем на своё.

## **Главная страница**

**Главная страница (ваш-сайт.ру/templates/шаблон/main.tpl)**
К тегу бади добавляем начальную структуру, должно выглядеть так

```html
<body itemscope itemtype="http://schema.org/WebPage">
```

## **Комментарии**

Комментарии (ваш-сайт.ру/templates/шаблон/comments.tpl)**
Этот шаг опционален, не столь важен, но всё же рекомендую.

В начало

```html
<div itemprop="comment" itemscope itemtype="http://schema.org/Comment">
    <meta itemprop="dateCreated" content="{date=Y-m-d}">
    <meta itemprop="author" content="{login}">
    <span itemprop="contentRating" style="display:none;">{rating}</span>
```

в конец

```html
</div>
```

строчка

```html
<span itemprop="contentRating" style="display:none;">{rating}</span>
```

для тех, кто использует рейтинг в комментариях. Рейтинг должен быть цифровой!
К аватарке добавляем значение image, должно выглядеть где-то так:

```html
<img itemprop="image" src="{foto}" width="100" height="100" class="img-responsive avatar" alt="Аватарка {login}'a">
```

сам комментарий так-же оборачиваем:

```html
<span itemprop="text">{comment}</span>
```

если используете рейтинг "нравится" и "не нравится", то оберните его следующим образом (тестировалось на дле 11)

```html
<div class="rating" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
        <link itemprop="itemReviewed" content="{news-link}#com-{comment-id}">
            <div class="mwrating">
                <div style="display:none;">
                    <span itemprop="ratingCount">{rating}</span>
                    <span itemprop="reviewCount">{rating}</span>
                    [negative-comment]<meta itemprop="bestRating" content="0">[/negative-comment]
                    [positive-comment]<span itemprop="bestRating">{rating}</span>[/positive-comment]
                    [neutral-comment]<span itemprop="bestRating">{rating}</span>[/neutral-comment]
                    [negative-comment]<span itemprop="worstRating">{rating}</span>[/negative-comment]
                    [positive-comment]<span itemprop="worstRating">0</span>[/positive-comment]
                    [neutral-comment]<span itemprop="worstRating">0</span>[/neutral-comment]
                </div>
                <div class="wmminus">[rating-minus]-[/rating-minus]</div>
                <div class="mwrat" itemprop="ratingValue">{rating}</div>
                <div class="wmplus">[rating-plus]+[/rating-plus]</div>
            </div>
    </div>
```

## **Хлебные крошки**

**Хлебные крошки (ваш-сайт.ру/templates/шаблон/speedbar.tpl)**
Заменяем всё содержимое на

```html
{speedbar}
```

Открываем **ваш-сайт.ру/templates/шаблон/стили/engine.css**
в самый низ добавляем (если у вас шаблон на основе бутстрапа 3, то пропускаем шаг)

```css
ol[typeof=BreadcrumbList]
{
    display:inline-block;
    list-style:none!important;
}
ol[typeof=BreadcrumbList] > li
{
    display:inline-block;
}
```

**/\00a0** можно заменить на **\00BB**
это заменит **/** на **»**
Открываем **ваш-сайт.ру/engine/engine.php**, ищем

```php
if ($config['speedbar'] AND !$view_template ) {
   
    $s_navigation = "<span itemscope itemtype=\"http://data-vocabulary.org/Breadcrumb\"><a href=\"{$config['http_home_url']}\" itemprop=\"url\"><span itemprop=\"title\">" . $config['short_title'] . "</span></a></span>";

    if( $config['start_site'] == 3 AND $_SERVER['QUERY_STRING'] == "" AND !$_POST['do']) $titl_e = "";

    if (intval($category_id)) $s_navigation .= " {$config['speedbar_separator']} " . get_breadcrumbcategories ( intval($category_id), $config['speedbar_separator'] );
    elseif ($do == 'tags') {
     
        if ($config['allow_alt_url']) $s_navigation .= " {$config['speedbar_separator']} <span itemscope itemtype=\"http://data-vocabulary.org/Breadcrumb\"><a href=\"" . $config['http_home_url'] . "tags/\" itemprop=\"url\"><span itemprop=\"title\">" . $lang['tag_cloud'] . "</span></a></span> {$config['speedbar_separator']} " . $tag;
        else $s_navigation .= " {$config['speedbar_separator']} <span itemscope itemtype=\"http://data-vocabulary.org/Breadcrumb\"><a href=\"?do=tags\" itemprop=\"url\"><span itemprop=\"title\">" . $lang['tag_cloud'] . "</span></a></span> {$config['speedbar_separator']} " . $tag;

    } elseif ($nam_e) $s_navigation .= " {$config['speedbar_separator']} " . $nam_e;

    if ($titl_e) $s_navigation .= " {$config['speedbar_separator']} " . $titl_e;
    else {

        if ( isset($_GET['cstart']) AND intval($_GET['cstart']) > 1 ){
     
            $page_extra = " {$config['speedbar_separator']} ".$lang['news_site']." ".intval($_GET['cstart']);
     
        } else $page_extra = '';

        $s_navigation .= $page_extra;

    }
   
    $tpl->load_template ( 'speedbar.tpl' );
    $tpl->set ( '{speedbar}', '<span id="dle-speedbar">' . stripslashes ( $s_navigation ) . '</span>' );
    $tpl->compile ( 'speedbar' );
    $tpl->clear ();

}
```

Меняем на:

```php
if ($config['speedbar'] AND !$view_template ) {
   
    $s_navigation = "<li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"{$config['http_home_url']}\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">" . $config['short_title'] . "</span></a><meta property=\"position\" content=\"1\"></li>";

    if( $config['start_site'] == 3 AND $_SERVER['QUERY_STRING'] == "" AND !$_POST['do']) $titl_e = "";

    if (intval($category_id))
    {
        $cat_breadcrumb = explode("|", get_breadcrumbcategories ( intval($category_id), $config['speedbar_separator'] ));
        $s_navigation .= " {$config['speedbar_separator']} " . $cat_breadcrumb[0];
    }
    elseif ($do == 'tags') {
     
        if ($config['allow_alt_url']) $s_navigation .= " {$config['speedbar_separator']} <li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"" . $config['http_home_url'] . "tags/\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">" . $lang['tag_cloud'] . "</span></a><meta property=\"position\" content=\"2\"></li> {$config['speedbar_separator']} <li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">" . $tag . "</span><meta property=\"position\" content=\"3\"></li>";
        else $s_navigation .= " {$config['speedbar_separator']} <li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"?do=tags\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">" . $lang['tag_cloud'] . "</span></a><meta property=\"position\" content=\"2\"></li> {$config['speedbar_separator']} <li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">" . $tag . "</span><meta property=\"position\" content=\"3\"></li>";

    } elseif ($nam_e)
    {
        if($dle_module == "showfull")
        {
            $cat_breadcrumb[1] = $cat_breadcrumb[1] + 1;
            $s_navigation .= " {$config['speedbar_separator']} " . "<li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">{$nam_e}</span><meta property=\"position\" content=\"{$cat_breadcrumb[1]}\"></li>";
        }
        else
        {
            $s_navigation .= " {$config['speedbar_separator']} " . "<li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">{$nam_e}</span><meta property=\"position\" content=\"2\"></li>";
        }
    }

    if ($titl_e)
    {
        if(isset($cat_breadcrumb[1]) && !is_null($cat_breadcrumb[1]))
            $cat_breadcrumb[1] = $cat_breadcrumb[1] + 1;
        else
            $cat_breadcrumb[1] = 3;
        $s_navigation .= " {$config['speedbar_separator']} <li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">{$titl_e}</span><meta property=\"position\" content=\"{$cat_breadcrumb[1]}\"></li>";
    }
    else {

        if ( isset($_GET['cstart']) AND intval($_GET['cstart']) > 1 ){
            $cat_breadcrumb[1]++;
            $page_extra = " {$config['speedbar_separator']} <li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">".$lang['news_site']." ".intval($_GET['cstart']) . "</span><meta property=\"position\" content=\"{$cat_breadcrumb[1]}\"></li>";
     
        } else $page_extra = '';

        $s_navigation .= $page_extra;

    }
   
    $tpl->load_template ( 'speedbar.tpl' );
    $tpl->set ( '{speedbar}', '<ol vocab="http://schema.org/" typeof="BreadcrumbList">' . stripslashes ( $s_navigation ) . '</ol>' );
    $tpl->compile ( 'speedbar' );
    $tpl->clear ();

}
```

Открываем **ваш-сайт.ру/engine/modules/functions.php**, ищем

```php
function get_breadcrumbcategories($id, $separator="»") {
   
    global $cat_info, $config, $PHP_SELF;
   
    if( ! $id ) return;
   
    $parent_id = $cat_info[$id]['parentid'];
   
    if( $config['allow_alt_url'] ) $list = "<span itemscope itemtype=\"http://data-vocabulary.org/Breadcrumb\"><a href=\"" . $config['http_home_url'] . get_url( $id ) . "/\" itemprop=\"url\"><span itemprop=\"title\">{$cat_info[$id]['name']}</span></a></span>";
    else $list = "<span itemscope itemtype=\"http://data-vocabulary.org/Breadcrumb\"><a href=\"$PHP_SELF?do=cat&category={$cat_info[$id]['alt_name']}\" itemprop=\"url\"><span itemprop=\"title\">{$cat_info[$id]['name']}</span></a></span>";
   
    while ( $parent_id ) {
     
        if( $config['allow_alt_url'] ) $list = "<span itemscope itemtype=\"http://data-vocabulary.org/Breadcrumb\"><a href=\"" . $config['http_home_url'] . get_url( $parent_id ) . "/\" itemprop=\"url\"><span itemprop=\"title\">{$cat_info[$parent_id]['name']}</span></a></span>" . " {$separator} " . $list;
        else $list = "<span itemscope itemtype=\"http://data-vocabulary.org/Breadcrumb\"><a href=\"$PHP_SELF?do=cat&category={$cat_info[$parent_id]['alt_name']}\" itemprop=\"url\"><span itemprop=\"title\">{$cat_info[$parent_id]['name']}</span></a></span>" . " {$separator} " . $list;
     
        $parent_id = $cat_info[$parent_id]['parentid'];

        if($parent_id) {    
            if( $cat_info[$parent_id]['parentid'] == $cat_info[$parent_id]['id'] ) break;
        }  
    }
   
    return $list;
}
```

меняем на

```
function get_breadcrumbcategories($id, $separator="»") {
   
    global $cat_info, $config, $PHP_SELF, $dle_module;
   
    if( ! $id ) return;
   
    $parent_id = $cat_info[$id]['parentid'];
    $first_id_p = $parent_id;
    $i = 1;
    while($parent_id)
    {
        $i++;
        $parent_id = $cat_info[$parent_id]['parentid'];
        if($parent_id)
            if( $cat_info[$parent_id]['parentid'] == $cat_info[$parent_id]['id'] ) break;
    }
   
    $i += 1;
    $parent_id = $first_id_p;
    if($parent_id == 0)
    {
        $id_i = 2;
        if($dle_module == "cat")
        {
            if( $config['allow_alt_url'] ) $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">{$cat_info[$id]['name']}</span><meta property=\"position\" content=\"2\"></li>";
            else $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><span itemprop=\"title\">{$cat_info[$id]['name']}</span><meta property=\"position\" content=\"2\"></li>";
        }
        else
        {
            if( $config['allow_alt_url'] ) $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"" . $config['http_home_url'] . get_url( $id ) . "/\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">{$cat_info[$id]['name']}</span></a><meta property=\"position\" content=\"2\"></li>";
            else $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"$PHP_SELF?do=cat&category={$cat_info[$id]['alt_name']}\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">{$cat_info[$id]['name']}</span></a><meta property=\"position\" content=\"2\"></li>";
        }
    }
    else
    {
        $id_i = 3;
        if($dle_module == "cat")
        {
            if( $config['allow_alt_url'] ) $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">{$cat_info[$id]['name']}</span><meta property=\"position\" content=\"{$i}\"></li>";
            else $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><span itemprop=\"title\">{$cat_info[$id]['name']}</span><meta property=\"position\" content=\"{$i}\"></li>";
        }
        else
        {
            if( $config['allow_alt_url'] ) $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"" . $config['http_home_url'] . get_url( $id ) . "/\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">{$cat_info[$id]['name']}</span></a><meta property=\"position\" content=\"3\"></li>";
            else $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"$PHP_SELF?do=cat&category={$cat_info[$id]['alt_name']}\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">{$cat_info[$id]['name']}</span></a><meta property=\"position\" content=\"3\"></li>";
        }
    }
    while ( $parent_id ) {
        $i--;
        if($dle_module != "cat")
        {
            if( $config['allow_alt_url'] ) $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"" . $config['http_home_url'] . get_url( $parent_id ) . "/\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">{$cat_info[$parent_id]['name']}</span></a><meta property=\"position\" content=\"{$i}\"></li>" . " {$separator} " . $list;
            else $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><a href=\"$PHP_SELF?do=cat&category={$cat_info[$parent_id]['alt_name']}\" property=\"item\" typeof=\"WebPage\"><span property=\"name\">{$cat_info[$parent_id]['name']}</span></a><meta property=\"position\" content=\"{$i}\"></li>" . " {$separator} " . $list;
        }
        else
        {
            if($id != $cat_info[$parent_id]['id'])
                $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><a property=\"item\" typeof=\"WebPage\" href=\"" . $config['http_home_url'] . get_url( $parent_id ) . "\"><span property=\"name\">{$cat_info[$parent_id]['name']}</span></a><meta property=\"position\" content=\"{$i}\"></li>" . " {$separator} " . $list;
            else
                $list = "<li property=\"itemListElement\" typeof=\"ListItem\"><span property=\"name\">{$cat_info[$parent_id]['name']}</span><meta property=\"position\" content=\"{$i}\"></li>" . " {$separator} " . $list;
        }
        $parent_id = $cat_info[$parent_id]['parentid'];
        if($parent_id) {    
            if( $cat_info[$parent_id]['parentid'] == $cat_info[$parent_id]['id'] ) break;
        }  
    }
    return $list . "|" . $id_i;
}
```

## **Рейтинг**

Это настроит вывод рейтинга. Ищем в **ваш-сайт.ру/engine/modules/functions.php**:

```php
<div id='ratig-layer-{$id}'><div class="rating">
        <ul class="unit-rating">
        <li class="current-rating" style="width:{$rating}%;">{$rating}</li>
        <li><a href="#" title="{$lang['useless']}" class="r1-unit" onclick="doRate('1', '{$id}'); return false;">1</a></li>
        <li><a href="#" title="{$lang['poor']}" class="r2-unit" onclick="doRate('2', '{$id}'); return false;">2</a></li>
        <li><a href="#" title="{$lang['fair']}" class="r3-unit" onclick="doRate('3', '{$id}'); return false;">3</a></li>
        <li><a href="#" title="{$lang['good']}" class="r4-unit" onclick="doRate('4', '{$id}'); return false;">4</a></li>
        <li><a href="#" title="{$lang['excellent']}" class="r5-unit" onclick="doRate('5', '{$id}'); return false;">5</a></li>
        </ul>
</div></div>
```

и меняем на

```php
<div id='ratig-layer-{$id}'><div class="rating">
        <ul class="unit-rating">
        <li itemprop="ratingValue" class="current-rating" style="width:{$rating}%;">{$rating}</li>
        <li itemprop="worstRating"><a href="#" title="{$lang['useless']}" class="r1-unit" onclick="doRate('1', '{$id}'); return false;">1</a></li>
        <li><a href="#" title="{$lang['poor']}" class="r2-unit" onclick="doRate('2', '{$id}'); return false;">2</a></li>
        <li><a href="#" title="{$lang['fair']}" class="r3-unit" onclick="doRate('3', '{$id}'); return false;">3</a></li>
        <li><a href="#" title="{$lang['good']}" class="r4-unit" onclick="doRate('4', '{$id}'); return false;">4</a></li>
        <li itemprop="bestRating"><a href="#" title="{$lang['excellent']}" class="r5-unit" onclick="doRate('5', '{$id}'); return false;">5</a></li>
        </ul>
</div></div>
```
