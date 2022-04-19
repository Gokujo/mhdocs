# Количество символов краткой новости

**Установка**

Открываем **engine/inc/addnews.php** и ищем

```php
</script>";
     
    $categories_list = CategoryNewsSelection( 0, 0 );
```

и ваше ставим

```javascript
$(document).ready(function() {

        $('#short_story').keyup(function(){
     
            var lentxt = $('#short_story').val().length;
            var lentxtos = $('#short_story').val().replace(/\s+/g,'').length;
            var total_words = $('#short_story').val().split(/[\s\.\?]+/).length;
            if(lentxt <= 499) { var color = '#cc0000'; }
            if(lentxt >= 500) { var color = '#09ad00'; }
            if(lentxt >= 32001) { var color = '#cc0000'; }
            $('#txtcount').html('Длина текста - '+lentxt+' символов с пробелами и '+lentxtos+' без').animate({color: ''+color+''},1000);
            $('#wordscount').html('Длина текста - '+total_words+' слов');
 
        });
       
    });
```

Открываем **engine/inc/editnews.php** и ищем

```php
</script>";

    $categories_list = CategoryNewsSelection( $cat_list, 0 );
```

и ваше ставим

```javascript
$(document).ready(function() {

        $('#short_story').keyup(function(){
     
            var lentxt = $('#short_story').val().length;
            var lentxtos = $('#short_story').val().replace(/\s+/g,'').length;
            var total_words = $('#short_story').val().split(/[\s\.\?]+/).length;
            if(lentxt <= 499) { var color = '#cc0000'; }
            if(lentxt >= 500) { var color = '#09ad00'; }
            if(lentxt >= 32001) { var color = '#cc0000'; }
            $('#txtcount').html('Длина текста - '+lentxt+' символов с пробелами и '+lentxtos+' без').animate({color: ''+color+''},1000);
            $('#wordscount').html('Длина текста - '+total_words+' слов');
 
        });
       
    });
```

В файлах **engine/inc/addnews.php** и **engine/inc/editnews.php** ищем

```php
</div>
                            </div>

                             <div class="form-group editor-group">
                              <label class="control-label col-lg-2">{$lang['addnews_full']}</label>
                              <div class="col-lg-10">
```

и выше ставим

```html
<br><var id="txtcount"></var><br>
                                <var id="wordscount"></var>
```

Всё. Теперь, когда в поле краткого поля менее 500 символов - текст будет красный, если 500 или более - зелёным. Однако, если текстовое поле наберёт более 32000 символов - опять покраснеет. Цифры появятся после проявления активности в самом поле