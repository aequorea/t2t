// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names

/*
** some testing code -- put it on the bottom so we can forget about it
*/

import 'unicode_fonts.dart';
import 'format_text.dart';

void test_all() {
  test_getcharwidth();
  test_getwordlength();
  test_romanencode();
}

void test_getcharwidth() {
  print("A ${getcharwidth('A')}");
  print("ᴀ ${getcharwidth('ᴀ')}");
  print("𝐴 ${getcharwidth('𝐴')}");
  print("");
}

void test_getwordlength() {
  print("ABC ${getwordlength('ABC')}");
  print("𝐴𝐵𝐶 ${getwordlength('𝐴𝐵𝐶')}");
  print("ᴀʙᴄ ${getwordlength('ᴀʙᴄ')}");
  print("");
}

void test_romanencode() {
  print('39 - ${romanencode(39)}');
  print('246 - ${romanencode(246)}');
  print('789 - ${romanencode(789)}');
  print('2421 - ${romanencode(2421)}');
  print('160 - ${romanencode(160)}');
  print('207 - ${romanencode(207)}');
  print('1009 - ${romanencode(1009)}');
  print('1066 - ${romanencode(1066)}');
  print('1776 - ${romanencode(1776)}');
  print('1918 - ${romanencode(1918)}');
  print('1944 - ${romanencode(1944)}');
  print('2023 - ${romanencode(2023)}');
  print('3888 - ${romanencode(3888)}');
  print('3999 - ${romanencode(3999)}');
  print('4999 - ${romanencode(4999)}');
}

void test_longS() {
  print(longSify('success.'));
  print(longSify(text_italicize('success\n')));
  print(longSify("ass's,"));
  print(longSify(text_italicize("ass's,")));
  print(longSify("ass’s,"));
  print(longSify(text_italicize("ass’s,")));
  print(longSify('darkness '));
  print(longSify(text_italicize('darkness ')));
  print(longSify('satisfied!'));
  print(longSify(text_italicize('satisfied.')));
  print(longSify('husband'));
  print(longSify(text_italicize('husband!')));
  print(longSify('skins'));
  print(longSify(text_italicize('skins????')));
  print(longSify('offspring'));
  print(longSify(text_italicize('offspring')));
  print(longSify('selfsame'));
  print(longSify(text_italicize('selfsame')));
  print(longSify('offscouring'));
  print(longSify(text_italicize('offscouring')));
}
