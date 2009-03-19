Введение
--------

Пакет disser предназначен для верстки дипломов и диссертаций. Ориентирован 
на руcскоязычных пользователей.


Зависимости
-----------

Класс использует стронние пакеты. Для корректной сборки всех шаблонов 
следует установить всё нижеперечисленное: 
amsfonts, amsmath, amssymb, caption, cmap, graphicx, hyperref, hypernat, 
multibib, natbib, oberdiek, pscyr (или cyrtimes), subfig, txfonts (или mtpro), 
wrapfig.

В данном списке не указаны пакеты, предназначенные для поддержки русского 
языка.


Получение последней версии
--------------------------

Репозиторий исходных текстов проекта доступен по следующим адресам:
http://mercurial.intuxication.org/hg/disser/
http://freehg.org/u/sk/disser/

Наиболее свежую версию пакета можно получить, скачав автоматически
генерируемый архив:
http://mercurial.intuxication.org/hg/disser/archive/tip.zip


Установка
---------

Автоматическая установка

В Unix-like ОС:
> env TEXMF=/путь/к/texmf make install
> mktexlsr

В Windows:
> set TEXMF=<путь к каталогу дистрибутива LaTeX>
> nomake install
> mktexlsr

Пример для пользователей MiKTeX:
set TEXMF=C:\Program Files\MiKTeX 2.7
nomake install
mktexlsr


Установка вручную

1. Создаем каталоги для класса, стиля библиографии и документации.
> mkdir /путь/к/texmf/tex/latex/disser
> mkdir /путь/к/texmf/bibtex/bst/disser
> mkdir /путь/к/texmf/doc/latex/disser
> mkdir /путь/к/texmf/doc/bibtex/disser

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

4. Копируем файлы в каталог назначения.
> cp *.cls *.rtx /путь/к/texmf/tex/latex/disser
> cp disser.bst /путь/к/texmf/bibtex/bst/disser

5. Устанавливаем документацию.
> cp disser.dvi disser.pdf gost732.dvi gost732.pdf /путь/к/texmf/doc/latex/disser
> cp disser-bst.dvi disser-bst.pdf /путь/к/texmf/doc/bibtex/disser

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
