# AutomaticRelated

**Автор**: Gameer

## Установка

1.  Залить все файлы к себе на сервер с архива, предварительно изменив название папки {THEME} на название своего шаблона
2.  Зайти в **Перестроение публикаций** - сделать **Перестроение кэша похожих новостей**
3.  Открыть **/engine/inc/addnews.php** найти :

```php
<li><a href="#tabperm" data-toggle="tab"><i class="icon-lock"></i> {$lang['tabs_perm']}</a></li>
```

Ниже вставить :

```html
<li><a href="#tabrelated" data-toggle="tab"><i class="icon-link"></i> Похожие новости</a></li>
```

Далее найти :

```html
<div class="tab-pane" id="tabperm" >
```

Выше вставить :

```html
<div class="tab-pane" id="tabrelated" >
	<div class="row box-section">
		<div class="form-group">
			<label class="control-label col-xs-2">Похожие новости</label>
			<div class="col-xs-10">
				<input type="text" style="width:99%;max-width:437px;" name="related_ids" id="related_ids" value=""><br><br>
				<input type="text" style="width:99%;max-width:437px;" id="search_news_input" name="newssearch" value="" placeholder="Поиск новостей"><br>
				<span id="related_newsd"></span>
			</div>
		</div>
	</div>
<script>
$(function(){
	$('#search_news_input').attr('autocomplete', 'off');
	var search_timer = false;
	var search_text = '';
	function EndSearch()
	{
		$('#search_news_input').keyup(function() {
			$('#related_newsd').text('');
			var text = $(this).val();
			if (search_text != text)
			{
				clearInterval(search_timer);
				search_timer = setInterval(function() { StartSearch(text); }, 600);
			}
		});
	}

	function StartSearch(text)
	{
		clearInterval(search_timer);
		$.post("engine/ajax/search_news.php", {news : text}, function(data){
			if(data){
				$('#related_newsd').text('');
				$('#related_newsd').append(data);
			}
		});
		search_text = text;
	}
	EndSearch();

	$('body').on('click', '[data-click*=news_]', function() {
		var id = $(this).attr('data-id');
		var arrs = $('[name=related_ids]').val().split(',');
		if (arrs.join(',').indexOf(id)>=0)
		{
			alert('Эта новость уже добавлена в похожие');
		}
		else
		{
			var related_ids = $('[name=related_ids]').val();
			if(related_ids == "" )
			{
				$('[name=related_ids]').val(related_ids + id);
				$("#findrelated_" + id).remove();
			}							
			else
			{
				$('[name=related_ids]').val(related_ids + ',' + id);
				$("#findrelated_" + id).remove();
			}
		}
	});
});
</script>
	</div>
</div>
```

Далее найти :

```php
disable_index = isset( $_POST['disable_index'] ) ? intval( $_POST['disable_index'] ) : 0;
```

Ниже вставить :

```php
$related_ids = isset( $_POST['related_ids'] ) ?  $_POST['related_ids'] : false;
```

Далее найти :

```php
$db->query( "INSERT INTO " . PREFIX . "_post_extras (news_id, allow_rate, votes, disable_index, access, user_id) VALUES('{$row}', '{$allow_rating}', '{$add_vote}', '{$disable_index}', '{$group_regel}', '{$userid}')" );
```

Заменить на :

```php
$db->query( "INSERT INTO " . PREFIX . "_post_extras (news_id, allow_rate, votes, disable_index, access, user_id, related_ids) VALUES('{$row}', '{$allow_rating}', '{$add_vote}', '{$disable_index}', '{$group_regel}', '{$userid}', '{$related_ids}')" );
```

* Открыть <b>/engine/inc/editnews.php</b> найти :

```php
<li><a href="#tabperm" data-toggle="tab"><i class="icon-lock"></i> {$lang['tabs_perm']}</a></li>
```

Ниже вставить : 

```html
<li><a href="#tabrelated" data-toggle="tab"><i class="icon-link"></i> Похожие новости</a></li>
```

Далее найти :

```html
<div class="tab-pane" id="tabperm" >
```

Выше вставить : 

```html
<div class="tab-pane" id="tabrelated" >
	<div class="row box-section">
		<div class="form-group">
			<label class="control-label col-xs-2">Похожие новости</label>
			<div class="col-xs-10">
				<input type="text" style="width:99%;max-width:437px;" name="related_ids" id="related_ids" value="{$row[related_ids]}"><br><br>
				<input type="text" style="width:99%;max-width:437px;" id="search_news_input" name="newssearch" value="" placeholder="Поиск новостей"><br>
				<span id="related_newsd"></span>
			</div>
		</div>
	</div>
<script>
$(function(){
	$('#search_news_input').attr('autocomplete', 'off');
	var search_timer = false;
	var search_text = '';
	function EndSearch()
	{
		$('#search_news_input').keyup(function() {
			$('#related_newsd').text('');
			var text = $(this).val();
			if (search_text != text)
			{
				clearInterval(search_timer);
				search_timer = setInterval(function() { StartSearch(text); }, 600);
			}
		});
	}

	function StartSearch(text)
	{
		clearInterval(search_timer);
		$.post("engine/ajax/search_news.php", {news : text}, function(data){
			if(data){
				$('#related_newsd').text('');
				$('#related_newsd').append(data);
			}
		});
		search_text = text;
	}
	EndSearch();

	$('body').on('click', '[data-click*=news_]', function() {
		var id = $(this).attr('data-id');
		var arrs = $('[name=related_ids]').val().split(',');
		if (arrs.join(',').indexOf(id)>=0)
		{
			alert('Эта новость уже добавлена в похожие');
		}
		else
		{
			var related_ids = $('[name=related_ids]').val();
			if(related_ids == "" )
			{
				$('[name=related_ids]').val(related_ids + id);
				$("#findrelated_" + id).remove();
			}							
			else
			{
				$('[name=related_ids]').val(related_ids + ',' + id);
				$("#findrelated_" + id).remove();
			}
		}
	});
});
</script>
	</div>
</div>
```

Далее найти : 

```php
$disable_index = isset( $_POST['disable_index'] ) ? intval( $_POST['disable_index'] ) : 0;
```

Ниже вставить :

```php
$related_ids = isset( $_POST['related_ids'] ) ?  $_POST['related_ids'] : false;
```

Далее найти : 

```php
if ($item_db[6]) $db->query( "UPDATE " . PREFIX . "_post_extras SET allow_rate='$allow_rating', votes='$add_vote', disable_index='$disable_index', access='$group_regel', editdate='$added_time', editor='{$member_id['name']}', reason='$editreason', view_edit='$view_edit' WHERE news_id='$item_db[0]'" );
```

Заменить на :

```php
if ($item_db[6]) $db->query( "UPDATE " . PREFIX . "_post_extras SET related_ids='$related_ids', allow_rate='$allow_rating', votes='$add_vote', disable_index='$disable_index', access='$group_regel', editdate='$added_time', editor='{$member_id['name']}', reason='$editreason', view_edit='$view_edit' WHERE news_id='$item_db[0]'" );
```

Далее найти :

```php
else $db->query( "INSERT INTO " . PREFIX . "_post_extras (news_id, allow_rate, votes, disable_index, access, editdate, editor, reason, view_edit) VALUES('{$item_db[0]}', '{$allow_rating}', '{$add_vote}', '{$disable_index}', '{$group_regel}', '{$added_time}', '{$member_id['name']}', '{$editreason}', '{$view_edit}')" ); 
```

Заменить на : 

```php
else $db->query( "INSERT INTO " . PREFIX . "_post_extras (news_id, allow_rate, votes, disable_index, access, editdate, editor, reason, view_edit, related_ids) VALUES('{$item_db[0]}', '{$allow_rating}', '{$add_vote}', '{$disable_index}', '{$group_regel}', '{$added_time}', '{$member_id['name']}', '{$editreason}', '{$view_edit}', '{$related_ids}')" );
```

*   В **fullstory.tpl** в нужном месте вставить : {include file="/engine/modules/related.php?newsid={news-id}&counts=4"} **Где counts** - лимит вывода похожих новостей (по умолчанию 5 новостей)  
    **Если нужно задать отдельный шаблон** добавить параметр tep. Пример : {include file="/engine/modules/related.php?newsid={news-id}&tep=new_temp"} И создать файл шаблона new_temp.tpl - оформления похожих и rentmp_new_temp.tpl - оформление блока.
*   **rentmp.tpl** (и другие что имееют отношение к оформлению блока для отдельного шаблона) - имеет теги :  
    1) **{related}** - вывод похожих новостей  
    2) **[related]текст[/related]** - выведет текст внутри тегов если есть похожие новости  
    3) **[not-related]текст[/not-related]** - выведет текст внутри тегов если нету похожих новостей  
    
*   **relatedn.tpl** (и другие что имееют отношение к выводу похожих новостей для отдельного шаблона) - имеет теги что и в краткой новости