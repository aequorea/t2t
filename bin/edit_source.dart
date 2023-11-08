// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names

/*
** here lie the edits to the source text
*/

// import 'file_io.dart';
import 'rune_stuff.dart';
import 'format_text.dart';

String doSpelling(String buf) {
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{2}', 'Now', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{2}', 'VS{5}', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{2}', 'VS{22}', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{3}', 'In', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{3}', 'VS{5}', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{4}', 'VS{25}', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{19}', 'And', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{24}', 'VS{16}', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Romans}', 'Chap{15}', 'VS{31}', 'Judaea', 'Judea');
  buf = doTxt(
      buf, 'Title{2 Corinthians}', 'ChapOne{1}', 'VS{16}', 'Judaea', 'Judea');
  buf =
      doTxt(buf, 'Title{Galatians}', 'ChapOne{1}', 'VS{22}', 'Judaea', 'Judea');
  buf = doTxt(
      buf, 'Title{1 Thessalonians}', 'Chap{2}', 'VS{14}', 'Judaea', 'Judea');
  buf = doTxt(buf, 'Title{Mark}', 'ChapOne{1}', 'VS{5}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{3}', 'VS{7}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{10}', 'And', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{13}', 'VS{14}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'ChapOne{1}', 'VS{5}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'ChapOne{1}', 'VS{65}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{2}', 'VS{4}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{3}', 'Now', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{5}', 'VS{17}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{6}', 'VS{17}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{7}', 'VS{17}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{21}', 'VS{21}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{John}', 'Chap{3}', 'VS{22}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{John}', 'Chap{4}', 'VS{3}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{John}', 'Chap{4}', 'VS{47}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{John}', 'Chap{4}', 'VS{54}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{John}', 'Chap{7}', 'VS{3}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{John}', 'Chap{11}', 'VS{7}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'ChapOne{1}', 'VS{8}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{2}', 'VS{9}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{2}', 'VS{14}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{8}', 'And', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{9}', 'VS{31}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{10}', 'VS{37}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{11}', 'And', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{11}', 'VS{29}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{12}', 'VS{19}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{15}', 'And', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{21}', 'VS{10}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{26}', 'VS{20}', 'Judæa', 'Judea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{28}', 'VS{21}', 'Judæa', 'Judea');

  buf =
      doTxt(buf, 'Title{Matthew}', 'Chap{16}', 'VS{13}', 'Caesarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{8}', 'VS{27}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{8}', 'VS{40}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{9}', 'VS{30}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{10}', 'There', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{10}', 'VS{24}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{11}', 'VS{11}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{12}', 'VS{19}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{12}', 'VS{29}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{21}', 'VS{8}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{21}', 'VS{16}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{23}', 'VS{23}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{23}', 'VS{33}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{25}', 'Now', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{25}', 'VS{4}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{25}', 'VS{6}', 'Cæsarea', 'Cesarea');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{25}', 'VS{13}', 'Cæsarea', 'Cesarea');

  buf = doTxt(buf, 'Title{Matthew}', 'Chap{22}', 'VS{17}', 'Caesar', 'Cesar');
  buf =
      doTxt(buf, 'Title{Philippians}', 'Chap{4}', 'VS{22}', 'Caesar', 'Cesar');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{22}', 'VS{21}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{22}', 'VS{21}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{22}', 'VS{21}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{12}', 'VS{14}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{12}', 'VS{16}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{12}', 'VS{17}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{12}', 'VS{17}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{2}', 'And', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{3}', 'Now', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{20}', 'VS{22}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{20}', 'VS{24}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{20}', 'VS{25}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{20}', 'VS{25}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{23}', 'VS{2}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{John}', 'Chap{19}', 'VS{12}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{John}', 'Chap{19}', 'VS{12}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{John}', 'Chap{19}', 'VS{15}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{11}', 'VS{28}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{17}', 'VS{7}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{15}', 'VS{8}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{15}', 'VS{10}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{15}', 'VS{11}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{15}', 'VS{12}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{15}', 'VS{12}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{15}', 'VS{21}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{16}', 'VS{32}', 'Cæsar', 'Cesar');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{17}', 'VS{24}', 'Cæsar', 'Cesar');

  buf = doTxt(buf, 'Title{Acts}', 'Chap{18}', 'VS{19}', 'Cæsar', 'Cesar');

  buf =
      doTxt(buf, 'Title{Mark}', 'Chap{14}', 'VS{70}', 'Galilaean', 'Galilean');
  buf =
      doTxt(buf, 'Title{Luke}', 'Chap{13}', 'There', 'Galilæans', 'Galileans');
  buf =
      doTxt(buf, 'Title{Luke}', 'Chap{13}', 'VS{2}', 'Galilæans', 'Galileans');
  buf =
      doTxt(buf, 'Title{Luke}', 'Chap{13}', 'VS{2}', 'Galilæans', 'Galileans');
  buf =
      doTxt(buf, 'Title{John}', 'Chap{4}', 'VS{45}', 'Galilæans', 'Galileans');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{2}', 'VS{7}', 'Galilæans', 'Galileans');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{22}', 'VS{59}', 'Galilæan', 'Galilean');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{23}', 'VS{6}', 'Galilæan', 'Galilean');

  buf = doTxt(
      buf, 'Title{Matthew}', 'Chap{27}', 'VS{27}', 'Arimathæa', 'Arimathea');
  buf =
      doTxt(buf, 'Title{Luke}', 'Chap{23}', 'VS{51}', 'Arimathæa', 'Arimathea');
  buf = doTxt(
      buf, 'Title{Mark}', 'Chap{15}', 'VS{43}', 'Arimathaea', 'Arimathea');
  buf = doTxt(
      buf, 'Title{John}', 'Chap{19}', 'VS{38}', 'Arimathaea', 'Arimathea');

  buf = doTxt(buf, 'Title{Acts}', 'Chap{9}', 'VS{33}', 'Æneas', 'Eneas');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{9}', 'VS{34}', 'Æneas', 'Eneas');

  buf = doTxt(buf, 'Title{Luke}', 'Chap{19}', 'VS{2}', 'Zacchæus', 'Zaccheus');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{19}', 'VS{5}', 'Zacchæus', 'Zaccheus');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{19}', 'VS{8}', 'Zacchæus', 'Zaccheus');

  buf = doTxt(buf, 'Title{Mark}', 'Chap{2}', 'VS{14}', 'Alphæus', 'Alpheus');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{6}', 'VS{15}', 'Alphæus', 'Alpheus');

  buf =
      doTxt(buf, 'Title{Mark}', 'Chap{10}', 'VS{46}', 'Bartimæus', 'Bartimeus');
  buf = doTxt(buf, 'Title{Mark}', 'Chap{10}', 'VS{46}', 'Timæus', 'Timeus');
  buf =
      doTxt(buf, 'Title{Mark}', 'Chap{15}', 'VS{16}', 'Prætorium', 'Pretorium');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{7}', 'VS{4}', 'Chaldæans', 'Chaldeans');

  buf = doTxt(buf, 'Title{Mark}', 'Chap{3}', 'VS{8}', 'Idumaea', 'Idumea');
  buf = doTxt(buf, 'Title{Luke}', 'Chap{3}', 'Now', 'Ituraea', 'Iturea');

  buf = doTxt(buf, 'Title{Esther (Greek)}', 'Chap{13}', 'The', 'governours',
      'governors');
  buf = doTxt(buf, 'Title{2 Maccabees}', 'Chap{12}', 'VS{2}', 'governours',
      'governors');

  buf = doTxt(buf, 'Title{Sirach}', 'Chap{7}', 'VS{31}', 'honor', 'honour');
  buf = doTxt(
      buf, 'Title{Sirach}', 'Chap{10}', 'VS{20}', 'honorable', 'honourable');
  buf = doTxt(
      buf, 'Title{Sirach}', 'Chap{48}', 'VS{6}', 'honorable', 'honourable');
  buf = doTxt(
      buf, 'Title{1 Maccabees}', 'Chap{10}', 'VS{64}', 'honored', 'honoured');
  buf = doTxt(
      buf, 'Title{Judith}', 'Chap{16}', 'VS{12}', 'fugatives', 'fugitives');
  buf = doTxt(buf, 'Title{1 Maccabees}', 'Chap{12}', 'VS{24}', "Demebius’",
      'Demetrius’');
  return buf;
}

/*
** fix misprints
*/

String doMisprints(String buf) {
  buf = doTxt(buf, 'Title{Genesis}', 'Chap{6}', 'VS{18}', "sons’", 'sons');
  buf = doTxt(buf, 'Title{Genesis}', 'Chap{7}', 'VS{7}', "sons’", 'sons');
  buf = doTxt(buf, 'Title{Genesis}', 'Chap{8}', 'VS{16}', "sons’", 'sons');
  buf = doTxt(buf, 'Title{Genesis}', 'Chap{8}', 'VS{18}', "sons’", 'sons');
  buf = doTxt(buf, 'Title{Genesis}', 'Chap{30}', 'VS{36}', "days’", 'days');
  buf = doTxt(buf, 'Title{Genesis}', 'Chap{31}', 'VS{23}', "days’", 'days');
  buf = doTxt(buf, 'Title{Exodus}', 'Chap{29}', 'VS{29}', "sons’", 'son’s');
  buf = doTxt(buf, 'Title{Judges}', 'Chap{8}', 'VS{21}', "camels’", 'camel’s');
  buf = doTxt(
      buf, 'Title{1 Samuel}', 'Chap{2}', 'VS{13}', "priests’", 'priest’s');
  buf = doTxt(buf, 'Title{2 Kings}', 'Chap{5}', 'VS{17}', "mules’", 'mules');
  buf = doTxt(
      buf, 'Title{1 Chronicles}', 'Chap{21}', 'VS{12}', "years’", 'years');
  buf = doTxt(buf, 'Title{Job}', 'Chap{42}', 'VerseOne', "Then", 'TNEN');
  buf = doTxt(buf, 'Title{Psalms}', 'Chap{107}', 'VS{27}', "wits’", 'wit’s');
  buf = doTxt(buf, 'Title{Proverbs}', 'Chap{30}', 'VS{28}', "kings’", 'king’s');
// change an apostrophe to a comma -- that's weird
  buf = doTxt(
      buf, 'Title{1 Esdras}', 'Chap{8}', 'VS{67}', 'stewards’', 'stewards,');
  buf =
      doTxt(buf, 'Title{Tobit}', 'Chap{11}', 'VS{11}', "fathers’", 'father’s');
  buf = doTxt(buf, 'Title{Judith}', 'Chap{9}', 'VerseOne', 'Judith fell',
      'Then Judith fell');
// change an apostrophe to a comma -- that's weird
  buf = doTxt(buf, 'Title{Sirach}', 'Chap{8}', 'VerseOne', 'mighty man’',
      'mighty man,');
  buf = doTxt(buf, 'Title{Sirach}', 'Chap{38}', 'VS{33}', "judges’", 'judge’s');
  buf = doTxt(buf, 'Title{Matthew}', 'Chap{5}', 'VS{10}', "theirs", 'their’s');
  buf = doTxt(buf, 'Title{Acts}', 'Chap{17}', 'VS{22}', "Mars’", 'Mars');
  buf = doTxt(buf, 'Title{Exodus}', 'Chap{23}', 'VS{15}', "Egypt:", 'Egypt,');
  buf = doTxt(buf, 'Title{Exodus}', 'Chap{17}', 'VS{15}', "Jehovah", 'JEHOVAH');
  buf = doTxt(buf, 'Title{Revelation}', 'ChapOne{1}', 'VS{18}',
      "{I {\\ADD{am}}", '{{\\ADD{I am}}');
  buf = doTxt(
      buf, 'Title{Exodus}', 'Chap{39}', 'VS{30}', "{\\ND{ LORD}}", 'LORD');
  buf = doTxt(
      buf, 'Title{2 John}', 'OneChap', 'VS{6}', "commandments", 'commannments');

  return buf;
}

String preformat_first_verse(String buf) {
  buf = doTxt(
      buf, 'Title{Deuteronomy}', 'Chap{16}', 'VerseOne', 'Observe', 'OBSERVE');
  buf = doTxt(
      buf, 'Title{2 Chronicles}', 'Chap{27}', 'VerseOne', 'Jotham', 'JOTHAM');
  buf = doTxt(
      buf, 'Title{2 Chronicles}', 'Chap{34}', 'VerseOne', 'Josiah', 'JOSIAH');
  buf = doTxt(buf, 'Title{Job}', 'Chap{2}', 'VerseOne', 'Again', 'AGain');
  buf = doTxt(buf, 'Title{Job}', 'Chap{31}', 'VerseOne', 'I made', 'I MADE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{1}', 'VerseOne', 'Blessed', 'BLESSED');
  buf = doTxt(buf, 'Title{Psalms}', 'Chap{65}', 'VerseOne', 'Praise', 'PRAISE');
  buf = doTxt(buf, 'Title{Psalms}', 'Chap{73}', 'VerseOne', 'Truly', 'TRuly');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{106}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{107}', 'VerseOne', 'O give', 'O GIVE');
  buf = doTxt(buf, 'Title{Psalms}', 'Chap{108}', 'VerseOne', 'O God', 'O GOD');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{111}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{112}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{113}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{135}', 'VerseOne', 'Praise', 'PRAISE');
  buf = doTxt(
      buf, 'Title{Psalms}', 'Chap{144}', 'VerseOne', 'Blessed', 'BLESSED');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{145}', 'VerseOne', 'I will', 'I WILL');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{146}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{147}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{148}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{149}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Psalms}', 'Chap{150}', 'VerseOne', 'Praise', 'PRAISE');
  buf =
      doTxt(buf, 'Title{Proverbs}', 'Chap{17}', 'VerseOne', 'Better', 'BETTER');
  buf = doTxt(buf, 'Title{Song of Solomon}', 'Chap{2}', 'VerseOne',
      'I {\\ADD{am}}', 'I {\\ADD{AM}}');
  buf = doTxt(
      buf, 'Title{Song of Solomon}', 'Chap{5}', 'VerseOne', 'I am', 'I AM');
  buf = doTxt(buf, 'Title{Isaiah}', 'Chap{52}', 'VerseOne', 'Awake', 'AWake');
  buf = doTxt(
      buf, 'Title{Jeremiah}', 'Chap{48}', 'VerseOne', 'Against', 'AGAINST');
  buf = doTxt(buf, 'Title{Hosea}', 'Chap{10}', 'VerseOne', 'Israel', 'ISRAEL');
  buf =
      doTxt(buf, 'Title{Habakkuk}', 'Chap{2}', 'VerseOne', 'I will', 'I WILL');
  buf =
      doTxt(buf, 'Title{Zephaniah}', 'Chap{2}', 'VerseOne', 'Gather', 'GATHER');
  buf = doTxt(buf, 'Title{Tobit}', 'Chap{5}', 'VerseOne', 'Tobias', 'TOBIAS');
  buf = doTxt(buf, 'Title{Wisdom}', 'Chap{8}', 'VerseOne', 'Wisdom reacheth',
      '{\\ADD{WISDOM}} reacheth');
  buf = doTxt(
      buf, 'Title{Wisdom}', 'Chap{16}', 'VerseOne', 'Therefore', 'THEREFORE');

// fix up the preliminary paragraphs in Sirach
  buf = doTxt(buf, 'Title{Sirach}', 'Title{Sirach}', 'Title{Sirach}',
      'This Jesus was', 'THIS Jesus was');
  buf = doTxt(buf, 'Title{Sirach}', 'Title{Sirach}', 'Title{Sirach}',
      'Whereas many and great', 'WHEREAS many and great');

  buf = doTxt(buf, 'Title{Sirach}', 'Chap{8}', 'VerseOne', 'Strive', 'STRIVE');

  buf = doTxt(buf, 'Title{Sirach}', 'Chap{16}', 'VerseOne', 'Desire', 'DESIRE');

// format the subtitle in Baruch 6
  buf = doTxt(
      buf, 'Title{Baruch}', 'Chap{6}', '\\VerseOne', '\\VerseOne{1}', '{\\D ');
  buf = doTxt(buf, 'Title{Baruch}', 'Chap{6}', '{\\D ', 'him of God.',
      'him of God. \\par }');
// and also the first paragraph of the text -- make it a verse one
  buf = doTxt(buf, 'Title{Baruch}', 'Chap{6}', 'VS{2}', 'VS{2}', 'VerseOne{2}');

  buf = doTxt(buf, 'Title{1 Maccabees}', 'Chap{9}', 'VerseOne', 'Furthermore',
      'FURTHERMORE');
  buf = doTxt(buf, 'Title{John}', 'Chap{15}', 'VerseOne', 'I am', 'I AM');
  buf = doTxt(
      buf, 'Title{1 Corinthians}', 'Chap{14}', 'VerseOne', 'Follow', 'FOLLOW');
  buf = doTxt(
      buf, 'Title{2 Corinthians}', 'Chap{7}', 'VerseOne', 'Having', 'HAVING');
  buf = doTxt(
      buf, 'Title{Philippians}', 'Chap{3}', 'VerseOne', 'Finally', 'FINALLY');
  buf = doTxt(buf, 'Title{2 Thessalonians}', 'Chap{3}', 'VerseOne', 'Finally',
      'FINALLY');

// put some verse ones in unexpected places
  buf = doTxt(buf, 'Title{Revelation}', 'ChapOne{1}', '\\VS{4}', '\\VS{4}',
      '\n\n\\VerseOne{4}');
  buf = doTxt(buf, 'Title{Luke}', 'ChapOne{1}', '\\VS{5}', '\\VS{5}',
      '\n\n5 \\VerseOne{5}');

  return buf;
}

String preformat_subtitles(String buf) {
  if (format_type == TEXT) {
    buf = doTxt(
        buf,
        'Title{Esther (Greek)}',
        'Title{Esther (Greek)}',
        'Title{Esther (Greek)}',
        '{\\SH PART OF THE TENTH CHAPTER AFTER THE GREEK',
        '{\\D 𝑃𝑎𝑟𝑡 𝑜𝑓 𝑡ℎ𝑒 𝑇𝑒𝑛𝑡ℎ 𝐶ℎ𝑎𝑝𝑡𝑒𝑟 𝑎𝑓𝑡𝑒𝑟 𝑡ℎ𝑒 𝐺𝑟𝑒𝑒𝑘.');

    buf = doTxt(
        buf,
        'Title{Sirach}',
        'Title{Sirach}',
        'Title{Sirach}',
        '{\\SH A Prologue made by an uncertain Author',
        '{\\D 𝐴 𝑃𝑟𝑜𝑙𝑜𝑔𝑢𝑒 𝑚𝑎𝑑𝑒 𝑏𝑦 𝑎𝑛 𝑢𝑛𝑐𝑒𝑟𝑡𝑎𝑖𝑛 𝐴𝑢𝑡ℎ𝑜𝑟.');

    buf = doTxt(
        buf,
        'Title{Sirach}',
        'Title{Sirach}',
        'Title{Sirach}',
        '{\\SH The Prologue of the Wisdom of Jesus the Son of Sirach.',
        '{\\D 𝑇ℎ𝑒 𝑃𝑟𝑜𝑙𝑜𝑔𝑢𝑒 𝑜𝑓 𝑡ℎ𝑒 𝑊𝑖𝑠𝑑𝑜𝑚 𝑜𝑓 Jesus 𝑡ℎ𝑒 𝑆𝑜𝑛 𝑜𝑓 𝑆𝑖𝑟𝑎𝑐ℎ.');
  } else {
    buf = doTxt(
        buf,
        'Title{Esther (Greek)}',
        'Title{Esther (Greek)}',
        'Title{Esther (Greek)}',
        '{\\SH PART OF THE TENTH CHAPTER AFTER THE GREEK',
        '{\\D //Part of the Tenth Chapter after the Greek.//');

    buf = doTxt(
        buf,
        'Title{Sirach}',
        'Title{Sirach}',
        'Title{Sirach}',
        '{\\SH A Prologue made by an uncertain Author',
        '{\\D //A Prologue made by an uncertain Author.//');

    buf = doTxt(
        buf,
        'Title{Sirach}',
        'Title{Sirach}',
        'Title{Sirach}',
        '{\\SH The Prologue of the Wisdom of Jesus the Son of Sirach.',
        '{\\D //The Prologue of the Wisdom of //Jesus// the Son of Sirach.//');
  }

  buf = doTxt(buf, 'Title{Baruch}', 'Title{Baruch}', 'Title{Baruch}',
      'The Epistle of Jeremy', 'The Epistle of JEREMY.');

//  write_source_file('$output_path/Bible_source_edited.txt', buf);
  return buf;
}

/*
** change the source text -- search and replace with some instrumentation
**   not quite bulletproof, but at least we're trying
*/
int numedits = 0;
String doTxt(String buf, book, chap, verse, toChange, changeTo) {
  numedits++;
  String errmsg = '$book $chap $verse $toChange --> $changeTo';
  int idx = buf.indexOf(book);
//  print(book);
  if (idx == -1) {
    print("Bad Book $book for $errmsg");
    return buf;
  }

  idx = buf.indexOf(chap, idx);
  if (idx == -1) {
    print("Bad Chapter for $errmsg");
    return buf;
  }

  idx = buf.indexOf(verse, idx);
  if (idx == -1) {
    print("Bad Verse for $errmsg");
    return buf;
  }

  idx = buf.indexOf(toChange, idx);
  if (idx == -1) {
    print("Bad change target for $errmsg");
    return buf;
  }

  if (runeLength(toChange) != toChange.length) {
    print('Exceptional rune length for $errmsg');
    print('rune length: ${runeLength(toChange)}');
    print('length attribute: ${toChange.length}');
    print('Change not done.');
    return buf;
  }

  buf = buf.replaceFirst(toChange, changeTo, idx);
  return buf;
}

/*
** move some things around
**   like chapter headers
**   avoid a double printed paragraph
**   get rid of verses in Manesseh
*/

String doStructuralEdits(String buf) {
  buf = editSirach(buf);
  buf = editEstherGreek(buf);
  buf = editBaruch(buf);
  buf = editManasseh(buf);

  return buf;
}

// reorganize file list
//   this is one of the first things we do
//   get rid of original front matter
//   reorder the apocrypha
String editFileList(String buf) {
  buf = buf.replaceFirst('\\input{FRT_src}\n', '');
  buf = buf.replaceFirst('\\input{TOB_src}\n',
      '\\input{1ES_src}\n\\input{2ES_src}\n\\input{TOB_src}\n');
  buf = buf.replaceFirst(
      '\\input{BEL_src}\n', '\\input{BEL_src}\n\\input{MAN_src}\n');
  buf = buf.replaceFirst(
      '\\input{1ES_src}\n\\input{MAN_src}\n\\input{2ES_src}\n', '');
  return buf;
}

// Manasseh -- capitalize leading Lord and remove versification
String editManasseh(String buf) {
  int idx = buf.indexOf('ShortTitle{Manasseh}');
  // Yeah -- it's not smallcaps
  buf = buf.replaceFirst('O Lord', 'O LORD', idx);
  // remove verse numbers -- 2 through 15
  for (int i = 2; i <= 15; i++) {
    buf = buf.replaceFirst(RegExp(r'\\VS{\d+}'), '', idx);
  }
  return buf;
}

// Baruch -- eliminate a double printed paragraph
String editBaruch(String buf) {
  int idx = buf.indexOf('ShortTitle{Baruch}');
  idx = buf.indexOf('\\Chap{6}', idx);
  buf = buf.replaceFirst(RegExp(r'{\\SH[\s\S]*? \\par }'), '', idx);
  return buf;
}

// Sirach -- put the chapter marker in the right place
String editSirach(String buf) {
  int idx = buf.indexOf('ShortTitle{Sirach}');
  idx = buf.indexOf('\\ChapOne{1}', idx);
  buf = buf.replaceFirst('\\ChapOne{1}', '', idx);
  buf = buf.replaceFirst('\\VerseOne{1}', '\\ChapOne{1}\n\\VerseOne{1}', idx);
  return buf;
}

// Greek Esther -- put the chapter marker in the right place
String editEstherGreek(String buf) {
  int idx = buf.indexOf('ShortTitle{Esther (Greek)}');
  idx = buf.indexOf('\\Chap{10}', idx);
  buf = buf.replaceFirst('\\Chap{10}', '', idx);
  buf = buf.replaceFirst('\\VS{4}', '\\Chap{10}\n\\VerseOne{4}', idx);
  return buf;
}

/*
** add the paragraph markers back in
*/

String redo_paragraph_markers(String buf, String paragraphs) {
  int bindex = 0; // book index
  String cbook = '';
  int cindex = 0; // chapter index -- becomes verse index
  String cchap = '';
  String search_str = '';

  // remove the original paragraph markers
  buf = buf.replaceAll('¶ ', '');
  buf = buf.replaceAll('¶', '');

  // make a list of paragraph markers that's easier to work with
  List<String> marker_list = generate_paragraph_marker_list(paragraphs);

  // put in the new ones
  for (String marker in marker_list) {
    List<String> mlist = marker.split('+');
    if (mlist[0] == '') print(marker);
    if (mlist[0] != cbook) {
      cbook = mlist[0];
      search_str = 'Title{$cbook}';
      bindex = buf.indexOf(search_str);
      // index chapter one from the book...
      // ...so we don't have to deal with ChapOne or OneChap
      if (mlist[1] == '1') {
        cchap = '1';
        cindex = bindex;
      } else {
        cchap = 'xxx'; // force chapter reset if not chapter one
      }
    }
    if (mlist[1] != cchap) {
      // psalms have no paragraph markers...
      // ...so we don't need to deal with PsalmChap
      cchap = mlist[1];
      search_str = 'Chap{$cchap}';
      cindex = buf.indexOf(search_str, bindex);
    }
    String verse = mlist[2];
    String pilcrow = '❡';
    if (verse[verse.length - 1] == '-') {
      pilcrow = '¶';
      verse = verse.substring(0, verse.length - 1);
    }
    if (verse[verse.length - 1] == '/') {
      pilcrow = '⛠';
      verse = verse.substring(0, verse.length - 1);
    }
    String vstr = 'VS{$verse}';
    buf = buf.replaceFirst(vstr, '$vstr$pilcrow ', cindex);
  }
  return buf;
}

// make list of paragraph markers
//   string of book+chapter+verse
//   trailing - or / retained to indicate marker size
List<String> generate_paragraph_marker_list(String paragraphs) {
  List<String> marker_list = [];
  List<String> paragraph_list = paragraphs.split('\n');
  String cbook = '';
  for (String paragraph in paragraph_list) {
    if (paragraph.isEmpty) continue;
    if (paragraph[0] == '#') continue;
    if (paragraph[0] == '(') {
      cbook = paragraph.substring(1, paragraph.length - 1);
      continue;
    }
    List<String> markers = paragraph.split(' ');
    if (markers.length > 1) {
      for (String cverse in markers.sublist(1)) {
        String cchap = markers[0];
        String marker = '$cbook+$cchap+$cverse';
        marker_list.add(marker);
      }
    }
  }
  return marker_list;
}
