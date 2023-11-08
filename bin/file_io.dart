// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names

/*
** file I/O
*/

import 'dart:io';

String input_path = './eng-kjv_xetex';
String style_path = '../bin';
String new_path = './new_additions';
String output_path = './output';

String in_file = 'all.tex';
String chapter_header_file = 'KJV_1769_chapter_headers.txt';
String titles_file = 'Titles_1769.txt';
String paragraph_file = 'paragraphs_1769.txt';

/*
** read a file into a string
*/

String read_file(String filename) {
//  print('Reading: $filename');
  File myFile = File(filename);
  myFile.openRead();
  return myFile.readAsStringSync();
}

/*
** write a file from a string
*/

write_file(String fn, String buf) {
  File myFile = File(fn);
  myFile.openWrite();
  myFile.writeAsStringSync(buf);
}

/*
** write a slightly formatted source file from a string
*/

write_source_file(String fn, String buf) {
  File myFile = File(fn);

  // do a little bit of formatting to make the source readable
  buf = buf.replaceAll('\\VerseOne', '\n\\VerseOne');
  buf = buf.replaceAll('\\VS', '\n\\VS');
  buf = buf.replaceAll('\\ChapOne', '\n\\ChapOne');
  buf = buf.replaceAll('\\Chap', '\n\\Chap');
  buf = buf.replaceAll('\\PsalmChapOne', '\n\\ChapOne');
  buf = buf.replaceAll('\\PsalmChap', '\n\\Chap');
  buf = buf.replaceAll('\\Normal', '\n\n\\Normal');
  buf = buf.replaceAll('{\\SH', '\n{\\SH');
  buf = buf.replaceAll('{\\D', '\n{\\D');

  myFile.openWrite();
  myFile.writeAsStringSync(buf);
}
