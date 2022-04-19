# Отдельные страницы как на кинопоиске

_**Для чего это вообще нужно?**_

**Для вебмастеров:** Если вы создаёте сайт с кино и к фильму добавляете ОЧЕНЬ много информации, но вам негде вывести её, то это поможет вам! Так вы сможете организовать вывод по отдельным страницам, при этом можно скрыть спарсенную информацию без проблем от поисковиков. А так-же, можно использовать эти страницы для доп. заработка.

**Для пользователей:** Опять же, ситуация, что и сверху, если на странице ОЧЕНЬ много информации, что обычный пользователь не поймёт что с ней делать или она в переизбытке, что до фильма не дойдёт и ходу.


Открываем **engine/engine.php**
ищем:

```php
switch ( $do ) {
```

и ниже ставим

```php
case "screens" :
        include ENGINE_DIR . '/modules/extrap/screens.php';
        break;
```


Теперь поясню:

**case "screens"** - вместо screens вписываем любое своё название, я применил такое для кадров и скриншотов, т.е. дальнейший адрес к скриншотам будет содержать название screens.

**/extrap/screens.php** - это указанный путь до шаблонизатора самой отдельной страницы. Я рекомендую создать отдельную папку для таких страниц, как у меня extrap, но можете просто и в папку **engine/modules** кинуть. Главное не забудьте поменять путь в коде для вставки выше

Ищем далее:

```php
elseif ($do == 'static') $titl_e = $static_descr;
```

Ниже ставим:

```php
elseif ($do == 'screens') $nam_e = "Скриншоты к ". $title;
```

Как вы поняли, тут мы настраиваем заголовок страницы. Указываем на своё усмотрение.

Теперь заходим в **engine/modules** и **создаём**файл **screens.php**. Поскольку я все страницы поместил в отдельную папку, то я создал сначала её, а в ней и сам файл создал.
В этот файл прописываем следующий код:

```php
<?php
if( !defined( 'DATALIFEENGINE' )) return;
$id_news = intval($_GET['id']);     //преемник нашего id новости
$row = $db->query("SELECT * FROM ".PREFIX."_post WHERE id='$id_news'");

while($list = $db->get_row( $row ))
{
    $title = $list['title'];
    $xf = xfieldsdataload($list['xfields']);

    if(!empty($xf['screens']))
        $screens = $xf['screens'];
    else
        $screens = "Скриншотов нет, но вы держитесь там!";

    if( $config['allow_alt_url'] ) {
        $full_link = $config['http_home_url'] . $id_news . "-".$list['alt_name'].".html";
    } else {
        $full_link = $config['http_home_url'] . "index.php?newsid=" . $id_news;
    }
}

$tpl->set( '{news-id}', $id_news);
$tpl->set( '{title}', $title);
$tpl->set( '{screens}', $screens);

$tpl->set( '{full-link}', $full_link );

$tpl->load_template( 'extrap/screens.tpl' );  //Ваш шаблон в папке с темой.

$tpl->compile( 'content' );
$tpl->clear();
?>
```

это примерный код. Давайте пройдёмся по пунктам:

```php
$title = $list['title'];
```

Подобным подключением мы выводим напрямую информацию из ячейки таблицы с фильмом. К примеру сам заголовок. А так-же мы присваиваем параметр определения, типа **$title**. А уже к нему само значение из базы, типа **$list['title']**. **$list** - отвечает за вывод информации из таблицы, **title**название ячейки с информацией такой трюк проделываем с каждой ячейкой, которая нам нужна.

```php
$xf = xfieldsdataload($list['xfields']);
    $kpid = $xf['kinopoisk_id'];
```

Это примерные параметры для вывода информации из доп. полей.

**$xf['kinopoisk_id']** - вместо **kinopoisk_id** прописываем название поля, которое вам нужно.
Вот так мы будем выводить скриншоты, к примеру.


```php
if(!empty($xf['screens']))
        $screens = $xf['screens'];
    else
        $screens = "Скриншотов нет, но вы держитесь там!";
```


этим кодом мы проверяем, если доп. поле со скриншотами не пустое, то выводим отформатированные кадры, если нет, то нам покажут такую справку:
> Скриншотов нет, но вы держитесь там!


Меняем на своё.

Идём далее, код:

```php
$tpl->set( '{news-id}', $id_news);
```

Этим кодом мы определяем теги, которые будут выводится в шаблоне. Думаю тут понятно что к чему. Тег и его определяющее значение.

Дальше:

```php
$tpl->load_template( 'extrap/screens.tpl' );
```

Тут определяем сам шаблон. Нужно его создать, об этом дальше.

С шаблонизатором покончили, теперь переходим в папку с вашим шаблоном и создаём файл шаблона. Я писал выше, что для отдельных страниц создал папку и туда внутрь кидаю все файлы.
И такой код получается у нас:

```html
<div class="full-wrap">
    <article class="extrap-item movie-full">
        <fieldset class="screenshots">
            <legend>Скриншоты и кадры к фильму</legend>
            {screens}
        </fieldset>
    </article>
</div>
```

Нужны ли тут объяснения? Думаю, что нет.

**Открываем .htaccess в корне сайта** и после

```apacheconf
RewriteEngine On
```

добавляем

```apacheconf
RewriteRule ^screens/([0-9]+)(/?)$ index.php?do=screens&id=$1 [L]
```

Тем самым мы получаем ссылку на страницу со скриншотами и можем в теги, типа **aviable**добавлять значение **screens**

На этом всё. Для каждой страницы повторяем все пункты с самого начала.


======
Небольшой бонус для тех, кто использует шаблон **FILMAX**. В файл шаблона **main.tpl** после

```html
[aviable=main]
         <div class="carou-wr">
            <div class="carou center">
                <div id="owl-carou">
                    {custom template="slider" aviable="global" order="rating" limit="15" cache="yes"}
                </div>
            </div>
        </div>
            [/aviable]
```

(это примерный код) ставим

```html
[aviable=showfull|screens|play|people|download]
        <div class="top-menu">
            <div class="container">
                <ul>
                    <li class="active[aviable=play] open[/aviable]"><a href="/play/{news-id}/">Смотреть онлайн</a></li>
                    <li class="active[aviable=showfull] open[/aviable]"><a href="/index.php?newsid={news-id}" rel="nofollow">Описание</a></li>
                    <li class="active[aviable=people] open[/aviable]"><a href="/people/{news-id}/">Съёмочная группа</a></li>
                    <li class="active[aviable=screens] open[/aviable]"><a href="/screens/{news-id}/">Кадры</a></li>
                </ul>
            </div>
        </div>
        [/aviable]
```

в стили добавляем

```css
.top-menu {
  width: 100%;
  height: 40px;
  display: block;
  background: #d2d5da;
}

.top-menu .container {
  padding: 0;
  background-color: transparent;
}

.top-menu ul {
  width: 100%;
  margin: 0 auto;
  display: table;
  list-style: none;
  position: relative;
}

.top-menu ul li {
  line-height: 40px;
  text-align: center;
  display: table-cell;
  vertical-align: middle;
}

.top-menu ul li.active a {
  width: 100%;
  color: #535865;
}

.top-menu ul li.active:hover a {
  color: #292c33;
  cursor: pointer;
}

.top-menu ul li.open {
  background: white;
}

.top-menu ul li.open a {
  color: #292c33;
}

.top-menu ul li a,.top-menu ul li span {
  outline: none;
  cursor: default;
  font-size: 12px;
  font-weight: bold;
  display: inline-block;
  text-transform: uppercase;
  color: rgba(83,88,101,0.3);
}

.top-menu ul li a .count,.top-menu ul li span .count {
  -webkit-border-radius: 2px;
  -moz-border-radius: 2px;
  -o-border-radius: 2px;
  border-radius: 2px;
  top: -1px;
  color: #FFF;
  height: 14px;
  padding: 0 3px;
  font-size: 11px;
  margin-left: 5px;
  font-weight: 400;
  line-height: 15px;
  text-align: center;
  position: relative;
  display: inline-block;
  vertical-align: middle;
  background-color: #8F95A3;
}

.top-menu.social li:last-child {
  width: 220px;
}
```

Открываем **engine/modules/main.php** и ищем:

```php
if ( $dle_module == "showfull" AND $news_found ) {
```

и меняем на

```php
if ($dle_module == "screens" || $dle_module == "play" || $dle_module == "people") {
    if (isset ( $_GET['id'] )) $newsid = intval ( $_GET['id'] ); else $newsid = 0;
    $tpl->set( '{news-id}', $newsid );
}
if ( $dle_module == "showfull" AND $news_found ) {

    if (isset ( $_GET['newsid'] )) $newsid = intval ( $_GET['newsid'] ); else $newsid = 0;
```

Принцип, думаю, понятен
В шаблоны можно подключить спокойно скрипты, которые подключаются через инклуд или апи. к примеру:

```html
<div class="full-wrap">
    <article class="movie-item movie-full">
        <div id="apivideoplayer"></div>
        <script type="text/javascript" src="http://kinospace.org/player/api.php?w=1264&h=650&kpid={kpid}&abuse={abuse}&trailers=yes&style=2&title={title}&poster={poster}"></script>
    </article>
</div>
```
