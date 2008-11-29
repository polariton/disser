Введение
--------

Пакет disser предназначен для верстки дипломов и диссертаций. Ориентирован 
на руcскоязычных пользователей.


Зависимости
-----------

Класс использует стронние пакеты. Для корректной сборки всех шаблонов 
следует установить всё нижеперечисленное: 
amsfonts, amsmath, amssymb, caption, cmap, graphicx, hyperref, hypernat, 
multibib, natbib, oberdiek, pscyr (or cyrtimes), txfonts (or mtpro), subfig, 
wrapfig.

В данном списке не указаны пакеты, предназначенные для поддержки русского 
языка.


Получение последней версии
--------------------------

Репозиторий проекта доступен по следующим адресам:
http://freehg.org/u/sk/disser
http://mercurial.intuxication.org/hg/disser/

Наиболее свежую версию пакета можно получить, скачав автоматически
генерируемый архив:
http://freehg.org/u/sk/disser/archive/tip.zip
http://mercurial.intuxication.org/hg/disser/archive/tip.zip


Установка
---------

Автоматически

В Unix-like ОС:
> env TEXMF=/путь/к/texmf make install
> mktexlsr

В Windows:
> set texmf=<путь к texmf или localtexmf>
> nomake install
> mktexlsr

Вручную

1. Создаем каталог.
> mkdir /путь/к/texmf/tex/latex/disser

2. Генерируем файлы классов.
> cd src
> latex disser.ins

3. Собираем документацию.
> latex disser.dtx
> makeindex -r disser
> latex disser.dtx
> latex disser.dtx
> latex gost732.dtx
> latex gost732.dtx
> pdflatex disser.dtx
> pdflatex disser.dtx
> pdflatex gost732.dtx
> pdflatex gost732.dtx

4. Копируем *.cls и *.rtx в каталог назначения.
> cp *.cls *.rtx /путь/к/texmf/tex/latex/disser

5. Устанавливаем документацию.
> cp *.dvi *.pdf /путь/к/texmf/doc/latex/disser

6. Обновляем базу имен файлов.
> mktexlsr


Лицензия
--------

Цопыригхт (ц) 2004-2009 Станислав Кручинин

Ит маы бе дистрибутед анд/ор модифиед ундер тхе
цондитионс оф тхе ЛаТеХ Пройецт Публиц Лиценсе, еитхер версион 1.3
оф тхис лиценсе ор (ат ёур оптион) аны латер версион.
Тхе латест версион оф тхис лиценсе ис ин
   хттп://ввв.латех-пройецт.орг/лппл.тхт
анд версион 1.3 ор латер ис парт оф алл дистрибутионс оф ЛаТеХ
версион 2003/12/01 ор латер.

Тхис програм ис дистрибутед ин тхе хопе тхат ит вилл бе усефул,
бут ВИТХОУТ АНЫ ВАРРАНТЫ; витхоут евен тхе имплиед варранты оф
МЕРЧАНТАБИЛИТЫ ор ФИТНЕСС ФОР А ПАРТИЦУЛАР ПУРПОСЕ.
