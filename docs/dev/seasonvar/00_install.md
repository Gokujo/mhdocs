# Seasonvar

Адаптивный шаблон для DLE

**Ссылка на разработку**: [<i class="fa-thin fa-paperclip"></i> Перейти к разработке](https://devcraft.club/shop/shablon-seasonvar.5/)

**Версия модификации**: <i class="fa-duotone fa-code-branch"></i> 1.0.0

## Возможности

!!! warning "!!!ИНСТРУКЦИЯ ОБНОВЛЕНА 04.02.2017!!!"

* Шаблон в кодировке UTF-8
* Автоматический вывод сериалов в алфавитное меню
* Правый блок выводит новости [стандартными средствами CMS](http://dle-news.ru/extras/online/startnews.html)
* Минимальный набор доп. полей
* Настроена микроразметка по телесериалам, как на главной, так и в полной новости
* Интегрирован модуль [MoonSerials от kild](http://kild.me/modules/2-modul-moonserials-v-145.html)
* Интегрирован модуль AutomaticRelated от Gameer
* Минимум графики: два логотипа, задний фон и подвал
* Код валиден и прошёл проверку валидатора
* Шаблон адаптивен влоть до 320px
* Шаблон был сделан на основе фреймворка Bootstrap 3, который был слегка изменён в 10 колонок.
* Есть примерные логотипы сизонвара для Photoshop и оригинальный исходник в Illustrator.

## Подключённые модули

* HDLight (0.9.7.4е)+Moonserials (1.4.5)
* TagsAdd (1.2.1)
* Алфавитное меню
* AutomaticRelated
* DLE-Asset

## Установка

* Советую устанавливать на чистый движок!
* Закачайте все файлы в корень сайта (если на момент установки версии ниже указанных выше - замените, иначе - пропусите)
* Если вы модофицировали файл engine/modules/pm.php, то следуйте инструкциям ниже, иначе загрузите его из папки "Дополнительно"
* Запустите сайт.ру**/hdlight\_install.php**
* Нужно создать доп. поля. Если у вас чистый движок и нет никаких полей, то добавьте файл xfields.txt из папки "Дополнительно" в engine/data на сервере, иначе следуйте инструкциям ниже
* Пройдитесь по всем настройкам и пересохраните

### Правка файлов

#### engine/modules/pm.php

**1. Ищем**

```php
					$tpl->set( '[inbox]', "<a href=\"$PHP_SELF?do=pm&folder=inbox\">" );
					$tpl->set( '[/inbox]', "</a>" );
					$tpl->set( '[outbox]', "<a href=\"$PHP_SELF?do=pm&folder=outbox\">" );
					$tpl->set( '[/outbox]', "</a>" );
					$tpl->set( '[new_pm]', "<a href=\"$PHP_SELF?do=pm&doaction=newpm\">" );
					$tpl->set( '[/new_pm]', "</a>" );
```

меняем на

```php
					$tpl->set( '[inbox]', "<a href=\"$PHP_SELF?do=pm&folder=inbox\" class=\"btn btn-default\" role=\"button\">" );
					$tpl->set( '[/inbox]', "</a>" );
					$tpl->set( '[outbox]', "<a href=\"$PHP_SELF?do=pm&folder=outbox\" class=\"btn btn-default\" role=\"button\">" );
					$tpl->set( '[/outbox]', "</a>" );
					$tpl->set( '[new_pm]', "<a href=\"$PHP_SELF?do=pm&doaction=newpm\" class=\"btn btn-default\" role=\"button\">" );
					$tpl->set( '[/new_pm]', "</a>" );
			
```

**2. Ищем**

```php
					$tpl->set( '{pm-progress-bar}', "<div class=\"pm_progress_bar\" title=\"{$lang['pm_progress_bar']} {$prlim}%\"><span style=\"width: {$prlim}%\">{$prlim}%</span></div>" );

```

меняем на

```php
					$tpl->set( '{pm-progress-bar}', "<div class=\"progress\"><div class=\"progress-bar progress-bar-danger progress-bar-striped active\" role=\"progressbar\" aria-valuenow=\"{$prlim}\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: {$prlim}%;\" title=\"{$lang['pm_progress_bar']} {$prlim}%\">{$prlim}%</div></div>" );
```

**3. Ищем**

```php
					$pmlist .= "<table class=\"pm\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><tr><td width=\"20\"> </td><td class=\"pm_head\">" . $lang['pm_subj'] . "</td><td width=\"130\" class=\"pm_head\">" . $lang['pm_from'] . "</td><td width=\"130\" class=\"pm_head\" align=\"center\">" . $lang['pm_date'] . "</td><td width=\"50\" class=\"pm_head\" align=\"center\"><input type=\"checkbox\" name=\"master_box\" title=\"{$lang['pm_selall']}\" onclick=\"javascript:ckeck_uncheck_all()\" /></td></tr>";
```

меняем на

```php
					$pmlist .= "<table class=\"table-striped\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><thead><tr><td>" . $lang['pm_subj'] . "</td><td>" . $lang['pm_from'] . "</td><td width=\"130\" align=\"center\">" . $lang['pm_date'] . "</td><td width=\"50\" align=\"center\"><input type=\"checkbox\" name=\"master_box\" title=\"{$lang['pm_selall']}\" onclick=\"javascript:ckeck_uncheck_all()\" /></td></tr></thead>";
```

**4. Ищем**

'''php
if( $row['pm_read'] ) {

			$subj = "<a class=\"pm_list\" href=\"$PHP_SELF?do=pm&doaction=readpm&pmid=" . $row['id'] . "\">" . stripslashes( $row['subj'] ) . "</a>";
			$icon = "{THEME}/dleimages/read.gif";

		} else {

			$subj = "<a class=\"pm_list\" href=\"$PHP_SELF?do=pm&doaction=readpm&pmid=" . $row['id'] . "\"><b>" . stripslashes( $row['subj'] ) . "</b></a>";
			$icon = "{THEME}/dleimages/unread.gif";

		}

		if( isset($row['reply']) AND $row['reply'] ) $icon = "{THEME}/dleimages/send.gif";

		$pmlist .= "<tr><td><img src=\"{$icon}\" border=\"0\" alt=\"\" /></td><td class=\"pm_list\">{$subj}</td><td class=\"pm_list\">{$user_from}</td><td class=\"pm_list\" align=\"center\">" . langdate( "j.m.Y H:i", $row['date'] ) . "</td><td class=\"pm_list\" align=\"center\"><input name=\"selected_pm[]\" value=\"{$row['id']}\" type=\"checkbox\" /></td></tr>";
'''

меняем на

'''php
if( $row['pm_read'] ) {

			$subj = "<a href=\"$PHP_SELF?do=pm&doaction=readpm&pmid=" . $row['id'] . "\">" . stripslashes( $row['subj'] ) . "</a>";
			$icon = "fa fa-envelope-o";

		} else {

			$subj = "<a href=\"$PHP_SELF?do=pm&doaction=readpm&pmid=" . $row['id'] . "\"><b>" . stripslashes( $row['subj'] ) . "</b></a>";
			$icon = "fa fa-envelope";

		}

		if( isset($row['reply']) AND $row['reply'] ) $icon = "fa fa-reply";

		$pmlist .= "<tr><td><i class=\"{$icon}\"></i> {$subj}</td><td>{$user_from}</td><td align=\"center\">" . langdate( "H:i, j.m.Y", $row['date'] ) . "</td><td align=\"center\"><input name=\"selected_pm[]\" value=\"{$row['id']}\" type=\"checkbox\" /></td></tr>";
'''

**5. Ищем**

```php
					if ($prev == 1)
										$pages .= "<a href=\"$PHP_SELF?{$user_query}\"> << </a> ";
									else
										$pages .= "<a href=\"$PHP_SELF?cstart=$prev&$user_query\"> << </a> ";
```
меняем на

```php
					if ($prev == 1)
										$pages .= "<li><a href=\"$PHP_SELF?{$user_query}\"><i class=\"fa fa-arrow-left\"></i></a></li>";
									else
										$pages .= "<li><a href=\"$PHP_SELF?cstart=$prev&$user_query\"><i class=\"fa fa-arrow-left\"></i></a></li>";
```
**6. Ищем**

```php
					if( $enpages_count <= 10 ) {

								for($j = 1; $j <= $enpages_count; $j ++) {

									if( $j != $cstart ) {

										if ($j == 1)
											$pages .= "<a href=\"$PHP_SELF?{$user_query}\">$j</a> ";
										else
											$pages .= "<a href=\"$PHP_SELF?cstart=$j&$user_query\">$j</a> ";

									} else {

										$pages .= "<span>$j</span> ";
									}
								}

							} else {

								$start = 1;
								$end = 10;
								$nav_prefix = "<span class=\"nav_ext\">{$lang['nav_trennen']}</span> ";

								if( $cstart > 0 ) {

									if( $cstart > 6 ) {

										$start = $cstart - 4;
										$end = $start + 8;

										if( $end >= $enpages_count ) {
											$start = $enpages_count - 9;
											$end = $enpages_count - 1;
											$nav_prefix = "";
									} else
											$nav_prefix = "<span class=\"nav_ext\">{$lang['nav_trennen']}</span> ";

									}

								}

								if( $start >= 2 ) {

									$pages .= "<a href=\"$PHP_SELF?{$user_query}\">1</a> <span class=\"nav_ext\">{$lang['nav_trennen']}</span> ";

								}

								for($j = $start; $j <= $end; $j ++) {

									if( $j != $cstart ) {
										if ($j == 1)
											$pages .= "<a href=\"$PHP_SELF?{$user_query}\">$j</a> ";
										else
											$pages .= "<a href=\"$PHP_SELF?cstart=$j&$user_query\">$j</a> ";

									} else {

										$pages .= "<span>$j</span> ";
									}

								}

								if( $cstart != $enpages_count ) {

									$pages .= $nav_prefix . "<a href=\"$PHP_SELF?cstart={$enpages_count}&$user_query\">{$enpages_count}</a>";

								} else
									$pages .= "<span>{$enpages_count}</span> ";

							}

							if( $pm_per_page < $count_all AND $cc < $count_all ) {
								$next_page = $cc / $pm_per_page + 1;
								$pages .= "<a href=\"$PHP_SELF?cstart=$next_page&$user_query\"> >> </a>";

							}
						}

						$pmlist .= "<tr><td colspan=\"5\"> </td></tr><tr><td colspan=\"2\"><div class=\"navigation\">{$pages}</div></td><td colspan=\"3\" align=\"right\"><select name=\"doaction\"><optgroup label=\"{$lang['edit_selact']}\"><option value=\"del\">{$lang['edit_seldel']}</option><option value=\"setread\">{$lang['pm_set_read']}</option><option value=\"setunread\">{$lang['pm_set_unread']}</option></optgroup></select>  <input class=\"bbcodes\" type=\"submit\" value=\"{$lang['b_start']}\" /></td></tr></table></form>";

						if( $i ) $tpl->set( '{pmlist}', $pmlist );
						else $tpl->set( '{pmlist}', $lang['no_message'] );

						$tpl->compile( 'content' );
						$tpl->clear();
					}
					?>
```
меняем на

```php
					if( $enpages_count <= 10 ) {

								for($j = 1; $j <= $enpages_count; $j ++) {

									if( $j != $cstart ) {

										if ($j == 1)
											$pages .= "<li><a href=\"$PHP_SELF?{$user_query}\">$j</a></li>";
										else
											$pages .= "<li><a href=\"$PHP_SELF?cstart=$j&$user_query\">$j</a></li>";

									} else {

										$pages .= "<li class=\"active\"><a>$j</a></li>";
									}
								}

							} else {

								$start = 1;
								$end = 10;
								$nav_prefix = "<li class=\"disabled\"><a>{$lang['nav_trennen']}</a></li>";

								if( $cstart > 0 ) {

									if( $cstart > 6 ) {

										$start = $cstart - 4;
										$end = $start + 8;

										if( $end >= $enpages_count ) {
											$start = $enpages_count - 9;
											$end = $enpages_count - 1;
											$nav_prefix = "";
									} else
											$nav_prefix = "<li class=\"disabled\"><a>{$lang['nav_trennen']}</a></li>";

									}

								}

								if( $start >= 2 ) {

									$pages .= "<li><a href=\"$PHP_SELF?{$user_query}\">1</a></li> <li class=\"disabled\"><a>{$lang['nav_trennen']}</a></li>";

								}

								for($j = $start; $j <= $end; $j ++) {

									if( $j != $cstart ) {
										if ($j == 1)
											$pages .= "<li><a href=\"$PHP_SELF?{$user_query}\">$j</a></li>";
										else
											$pages .= "<li><a href=\"$PHP_SELF?cstart=$j&$user_query\">$j</a></li>";

									} else {

										$pages .= "<li class=\"active\"><a>$j</a></li> ";
									}

								}

								if( $cstart != $enpages_count ) {

									$pages .= $nav_prefix . "<li><a href=\"$PHP_SELF?cstart={$enpages_count}&$user_query\">{$enpages_count}</a></li>";

								} else
									$pages .= "<li class=\"disabled\"><a>{$enpages_count}</a></li> ";

							}

							if( $pm_per_page < $count_all AND $cc < $count_all ) {
								$next_page = $cc / $pm_per_page + 1;
								$pages .= "<li><a href=\"$PHP_SELF?cstart=$next_page&$user_query\"><i class=\"fa fa-arrow-right\"></i></a></li>";

							}
						}

						$pmlist .= "</table><table class=\"table\"><tr><td colspan=\"2\"><div class=\"navigation\">{$pages}</div></td><td colspan=\"2\" align=\"right\"><select name=\"doaction\" class=\"form-control\"><optgroup label=\"{$lang['edit_selact']}\"><option value=\"del\">{$lang['edit_seldel']}</option><option value=\"setread\">{$lang['pm_set_read']}</option><option value=\"setunread\">{$lang['pm_set_unread']}</option></optgroup></select>  <input class=\"btn btn-danger\" type=\"submit\" value=\"{$lang['b_start']}\" /></td></tr></table></form>";

						if( $i ) $tpl->set( '{pmlist}', $pmlist );
						else $tpl->set( '{pmlist}', $lang['no_message'] );

						$tpl->compile( 'content' );
						$tpl->clear();
					}
					?>
```
#### engine/data/xfields.txt

Если у вас уже есть поля, то вам нужно заменить все поля, кроме полей для актёров (actor), режиссёров (director), ключевых слов (keywords), страны (contributor) и года (copyrightyear), на свои в следующих файлах шаблона: fullstory.tpl, shortstory.tpl, main.tpl, modules/side-block.tpl (в шаблоне), modules/filter.tpl (в шаблоне), moonserials/moonserials\_block.tpl (в шаблоне), moonserials/moonserials\_block\_content.tpl (в шаблоне)

Если у вас уже есть поля для актёров (actor), режиссёров (director), ключевых слов (keywords), страны (contributor) и года (copyrightyear), но они не соответствуют значениям в скобках, то делаем следующее:

* идём в phpMyAdmin в таб SQL
* вставляем:

```sql
    UPDATE `dle_post` SET `xfields`=REPLACE(`xfields`,'СтароеНазвание','НовоеНазвание');
```
* открываем /engine/data/xfields.txt и меняем поля
* идём в админку в управление доп. полями
* выбираем любое на редактирование и пересохраняем его
* чистим кеш

#### Прочие правки

* Открываем engine/modules/show.short/full/custom.php и ищем

```php
    if( $config['allow_alt_url'] ) $my_cat_link[] = "<a
```
и

```php
    else $my_cat_link[] = "<a
```
после добавим

```php
itemprop=\"genre\"
```
* Замените ID категорий в main.tpl
* Замените названия меню и их вывод в modules/menu.tpl
* Открываем engine/modules/show.full.php и ищем

```php
$tpl->compile( 'content' );

		if( $user_group[$member_id['user_group']]['allow_hide'] ) $tpl->result['content'] = str_ireplace( "[hide]", "", str_ireplace( "[/hide]", "", $tpl->result['content']) );
```
и ВЫШЕ ставим

```php
		/*Добавление тегов*/
		include ENGINE_DIR . '/data/tagsadd.php';
		if($tagsconf['onof'] == 1) {
			$tagsfull = "<a href=\"#\" role=\"button\" id=\"TagsAdd\">{$tagsconf['button']}</a><div style=\"display: none;\"><div class=\"box-modal\" id=\"AddTags\"><div class=\"box-modal_close arcticmodal-close\">закрыть</div><form action=\"/tags.php\" method=\"post\"><input class=\"form-control\" type=\"text\" placeholder=\"теги\" name=\"utags\" id=\"utags\"><input type=\"hidden\" name=\"news\" value=\"".$id."\"><input type=\"hidden\" name=\"username\" value=\"".$user."\"><input type=\"hidden\" name=\"userid\" value=\"".$userid."\"><input type=\"hidden\" name=\"link\" value=\"".$link."\"><input type=\"hidden\" name=\"title\" value=\"".$name."\"><br><br><button class=\"btn btn-block btn-success\" onclick=\"submit();\" id=\"add_tags\">Отправить</button></form></div></div>";
			$tagsbutton = "<a href=\"#\" role=\"button\" id=\"TagsAdd\">{$tagsconf['button']}</a>";
			$tagsbody = "<div style=\"display: none;\"><div class=\"box-modal\" id=\"AddTags\"><div class=\"box-modal_close arcticmodal-close\">закрыть</div><form action=\"/tags.php\" method=\"post\"><input class=\"form-control\" type=\"text\" placeholder=\"теги\" name=\"utags\" id=\"utags\"><input type=\"hidden\" name=\"news\" value=\"".$id."\"><input type=\"hidden\" name=\"username\" value=\"".$user."\"><input type=\"hidden\" name=\"userid\" value=\"".$userid."\"><input type=\"hidden\" name=\"link\" value=\"".$link."\"><input type=\"hidden\" name=\"title\" value=\"".$name."\"><br><br><button class=\"btn btn-block btn-success\" onclick=\"submit();\" id=\"add_tags\">Отправить</button></form></div></div>";

			$id = $row['id'];
			$name = $row['title'];
			$link = $full_link;

			if($tagsconf['guest'] == 1 && empty($member_id['name'])) {
				$user = "Гость";
				$userid = 0;
			} else {
				$user = $member_id['name'];
				$userid = $member_id['user_id'];
			}

			$tags = $_POST['utags'];

			if($tagsconf['guest'] == 1)  {
				$tpl->set( '{tagsadd}', $tagsfull );
				$tpl->set( '{tagsbutton}', $tagsbutton);
				$tpl->set( '{tagsbody}', $tagsbody);
				$tpl->set_block( "'\\[usertags\\](.*?)\\[/usertags\\]'si", "\\1" );
				$tpl->set_block( "'\\[not-usertags\\](.*?)\\[/not-usertags\\]'si", "" );
			} else {
				if($is_logged) {
					$tpl->set( '{tagsadd}', $tagsfull );
					$tpl->set( '{tagsbutton}', $tagsbutton);
					$tpl->set( '{tagsbody}', $tagsbody);
					$tpl->set_block( "'\\[usertags\\](.*?)\\[/usertags\\]'si", "\\1" );
					$tpl->set_block( "'\\[not-usertags\\](.*?)\\[/not-usertags\\]'si", "" );
				} else {
					$tpl->set( '{tagsadd}', "");
					$tpl->set( '{tagsbutton}', "");
					$tpl->set( '{tagsbody}', "");
					$tpl->set_block( "'\\[usertags\\](.*?)\\[/usertags\\]'si", "" );
					$tpl->set_block( "'\\[not-usertags\\](.*?)\\[/not-usertags\\]'si", "\\1" );
				}
			}

		} else {
			$tpl->set( '{tagsadd}', "");
			$tpl->set( '{tagsbutton}', "");
			$tpl->set( '{tagsbody}', "");
			$tpl->set_block( "'\\[usertags\\](.*?)\\[/usertags\\]'si", "" );
			$tpl->set_block( "'\\[not-usertags\\](.*?)\\[/not-usertags\\]'si", "\\1" );
		}

		/*Добавление тегов*/
```
* Открываем .htaccess и после

```apache
RewriteEngine On
```
ставим

```apache
											#Пользовательские теги
RewriteRule ^tags.php index.php?do=tag [L,QSA]
```
* Открываем engine/engine.php и после

```php
switch ( $do ) {
```
ставим

```php
											case "tag" :
												include ENGINE_DIR . '/modules/tags.php';
												break;
```
#### AutomaticRelated

[Перейти к установке](01_related.md)
