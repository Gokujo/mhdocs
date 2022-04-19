# ReleaseStatus

**Ссылка на разработку**: [<i class="fa-thin fa-paperclip"></i> Перейти к разработке](https://devcraft.club/downloads/releasestatus.6/)

**Версия модификации**: <i class="fa-duotone fa-code-branch"></i> 1.0.0

## **Установка**

- Залить файлы из папки uploads в корень сайта (уделите внимание папке Default в папке templates)
- Запустите файл install.php в корне вашего сайта, а затем удалите
- В шаблонах откройте файл main.tpl и пропишите до

```html
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-128839302-1"></script>
<script>
        
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    
        gtag('config', 'UA-128839302-1', {"anonymize_ip":true});
    
        </script>
</head>
```

```html
<link href="{THEME}/releasestatus/main.css" type="text/css" rel="stylesheet">
```

- В этом же файле, или любом другом файле шаблона, прописываем это для вывода блока 

```html
{include file="engine/modules/releasestatus.php"}
```

- На файл engine/data/releasestatus.php выставить права 666


**Теги для release_block.tpl**

- {image}, {image-1}, {image-*} - При условии, что изображения выводятся из короткой или полной новости
- {poster} - При условии, если изображение выводится из доп. поля
- {title} - Выводит название в зависимости от вывода, настроенного в настройках
- {type} - Выводит тип релиза, полнометражку или сериал
- {number} - Выводит номер серии, если релиз полнометражка - не выводится
- {translate_name} - Выводит название поля: "Перевод"
- {dub_name} - Выводит название поля: "Озвучка"
- {montage_name} - Выводит название поля: "Монтаж"
- {post_name} - Выводит название поля: "Проверка"
- {translate} - Выводит значение для поля: "Перевод"
- {dub} - Выводит значение для поля: "Озвучка"
- {montage} - Выводит значение для поля: "Монтаж"
- {post} - Выводит значение для поля: "Проверка"
- {suffix} - Выводит знак процента
- {progress} - Выводит прогрессбар, статус в процентах. Если отключены показы в процентах, то и прогрессбара не будет
- {link} - Ссылка на новость
- {id} - ID статуса
- [status][/status] - Скрывает текст, если отключён показ нуллевых значений (пока в стадии обдумки)
- [link][/link] - Заключённый текст превратится в ссылку на новость

<div class="video-wrapper">
  <iframe width="1280" height="720" src="https://www.youtube.com/embed/fV5FwefJqhY" frameborder="0" allowfullscreen></iframe>
</div>