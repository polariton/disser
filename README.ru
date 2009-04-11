Введение
--------

Пакет disser предназначен для верстки дипломов, диссертаций и авторефератов 
в соответствии с требованиями, предъявляемыми ВАК РФ.


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

Пакет disser доступен на CTAN:
  http://www.ctan.org/tex-archive/macros/latex/contrib/disser/

ZIP-файл с исходными текстами:
  http://www.ctan.org/get/macros/latex/contrib/disser.zip

ZIP-файл с собранными файлами и документацией, отсортированными в соответствии со
стандартной структурой каталогов TeX:
  http://tug.ctan.org/pub/tex-archive/install/macros/latex/contrib/disser.tds.zip

Репозитории исходных текстов проекта:
  http://mercurial.intuxication.org/hg/disser/
  http://disser.hg.sourceforge.net/hgweb/disser/
  http://bitbucket.org/sky/disser/

Наиболее свежую версию пакета можно получить, скачав автоматически
генерируемый архив:
  http://mercurial.intuxication.org/hg/disser/archive/tip.zip

Структура файлов и каталогов архива исходных текстов disser.zip:
  ./
    Корневой каталог содержит файлы ChangeLog, README, README.ru, Makefile,
    nomake.cmd. Версия, скачанная из репозитория также содержит служебные файлы 
    .hg*.

  include/
    Каталог со скриптами, которые подключаются из файлов Makefile и nomake.cmd.

  src/
    Каталог с исходными текстами пакета.

  doc/
    Каталог с пользовательской документацией.

  templates/
    Каталог для шаблонов документов.


Установка
---------

1. Установка из исходных текстов

В Unix-like ОС:
  env TEXMF=/путь/к/texmf make install
  mktexlsr

В Windows:
  set TEXMF=<путь к каталогу дистрибутива LaTeX>
  nomake install
  mktexlsr

Пример для пользователей MiKTeX:
set TEXMF=C:\Program Files\MiKTeX 2.7
nomake install
mktexlsr


2. Установка из исходных текстов вручную

a. Создаем каталоги для класса, стиля библиографии и документации.
  mkdir /путь/к/texmf/tex/latex/disser
  mkdir /путь/к/texmf/bibtex/bst/disser
  mkdir /путь/к/texmf/doc/latex/disser
  mkdir /путь/к/texmf/doc/bibtex/disser

b. Генерируем файлы классов.
  cd src
  latex disser.ins

c. Собираем документацию.
  pdflatex disser.dtx
  makeindex -r disser
  pdflatex disser.dtx
  pdflatex disser.dtx
  pdflatex gost732.dtx
  pdflatex gost732.dtx
  pdflatex disser-bst.dtx
  pdflatex disser-bst.dtx

d. Копируем файлы в каталог назначения.
  cp *.cls *.rtx /путь/к/texmf/tex/latex/disser
  cp disser.bst /путь/к/texmf/bibtex/bst/disser

e. Устанавливаем документацию.
  cp manual.pdf disser.pdf gost732.pdf disser-bst.pdf /путь/к/texmf/doc/latex/disser

f. Обновляем базу имен файлов.
  mktexlsr


3. Установка из ZIP-архива со скомпилированными файлами

Файл disser.tds.zip содержит собранные файлы классов и документации, 
поэтому его можно просто распаковать в каталог, в котором установлен TeX.

Пример:
  cd /путь/к/texmf
  unzip /путь/к/файлу/disser.tds.zip

После установки следует обновить базу имен файлов.
  mktexlsr


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
