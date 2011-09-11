1. ��������
-----------

����� disser ������������ ��� ������� ��������, ����������� � �������������
� ������������ � ������������ ��������������� ������� � ��� ��.


2. ������������� ������ � ���������
-----------------------------------

��� ���������� ������ ���������� � ����� ������������ LaTeX ������ ����
����������� ��������� ������:
amsfonts, amsmath, amssymb, caption, cmap, graphicx, ifpdf, kvoptions,
natbib, hyperref, subfig, wrapfig, � ����� ������ ��� ���������
�������� �����.

��� ������������� ������ Times � ��������� ������ ������� ����������
����� pscyr ��� cyrtimes, � �������������� ������ --- txfonts ��� mtpro.

��� ������������������ ��������� �������� � ������� �������� Makefile �
nomake.cmd ������� ���������� ��������� Ghostscript, epstool � sam2p.


3. ��������� ��������� ������
-----------------------------

����� disser �������� �� CTAN:
  http://www.ctan.org/tex-archive/macros/latex/contrib/disser/

�������� ������� �� Sourceforge:
  http://sourceforge.net/projects/disser/

ZIP-����� � ��������� ��������:
  http://www.ctan.org/get/macros/latex/contrib/disser.zip

ZIP-����� � �������� ������� � �������������, ������� ��������� �
������������ �� ����������� ���������� ��������� TeX
(��. ���� disser-<version>.tds.zip � ������� Download):
  http://sourceforge.net/projects/disser/

��������� ����������� �������� ������� �������:
  http://mercurial.intuxication.org/hg/disser/
  http://bitbucket.org/sky/disser/
  http://disser.hg.sourceforge.net/hgweb/disser/

�������� ������ ������ �������� ������� ������ ����� ��������, ������
������������� ������������ ����� � ������ �� ������������:
  http://mercurial.intuxication.org/hg/disser/archive/tip.zip
  http://bitbucket.org/sky/disser/get/tip.zip


4. ���������
------------

1. �� �������� �������

��� ��������� ���������� ������� � ������� � �������������� ���������
�������� � ��������� ��������� �������

� Unix-�������� ����������:
  env DESTDIR=/����/�/texmf make install

� Windows:
  set DESTDIR=����:\����\�\texmf
  nomake install

����� /����/�/texmf � ����:\����\�\texmf -- ���� � ������ ��������� TeX.
����� ��������� ������� �������� ���� ���� ������ � ������� �������
  mktexlsr

������� ������ ��� ������������ MiKTeX ������ 2.9 � Windows 7.

��������� ��� ���� �������������:
  set DESTDIR=%ALLUSERSPROFILE%\MiKTeX\2.9
  nomake install
  mktexlsr --admin

��������� ������ ��� �������� ������������:
  set DESTDIR=%APPDATA%\MiKTeX\2.9
  nomake install
  mktexlsr


2. �� ZIP-������ �� ����������������� �������

���� disser-<version>.tds.zip �������� ��������� ����� ������� �
������������, ������� ��� ����� ������ ����������� � ������� TeX.

������ ��� Unix-�������� ���������:
  cd /����/�/texmf
  unzip /����/�/�����/disser-<version>.tds.zip
  mktexlsr

������ ��� Windows:
  cd ����:\����\�\texmf
  unzip ����:\����\�\�����\disser-<version>.tds.zip
  mktexlsr


5. ��������
-----------

��������� (�) 2004-2012 ��������� ��������

�� ��� �� ����������� ���/�� �������� ����� ���
���������� �� ��� ����� ������� ������ �������, ������ ������� 1.3
�� ���� ������� �� (�� ��� ������) ��� ����� �������.
��� ������ ������� �� ���� ������� �� ��
   ����://���.�����-�������.���/����.���
��� ������� 1.3 �� ����� �� ���� �� ��� ������������� �� �����
������� 2003/12/01 �� �����.

���� ������� �� ����������� �� ��� ���� ���� �� ���� �� ������,
��� ������� ��� ��������; ������� ���� ��� ������� �������� ��
�������������� �� ������� ��� � ���������� �������.
