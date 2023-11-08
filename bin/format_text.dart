// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names
//   ignore_for_file: prefer_interpolation_to_compose_strings
/*
** text formatter
*/

import 'rune_stuff.dart';
import 'unicode_fonts.dart';
import 'file_io.dart';

const TEXT = 1;
const MARKUP = 2;
const HTML = 3;

const ALL = 9;

int maxlinelen = 46; // max length of line emitted by paragraph formatter
int format_type = TEXT;

int current_book = 0;
List<String> chapter_header_list = [];
List<String> book_list = [];
List<String> marker_list = [];

String markup_to_text(String buf, int ftype) {
  int old_format_type = format_type;
  format_type = ftype;
  // embedded large italics
  buf = buf.replaceAllMapped(
      RegExp(r'///(.*?)///'), (m) => text_italicize(m[1]!));
  // embedded italics
  buf =
      buf.replaceAllMapped(RegExp(r'//(.*?)//'), (m) => text_italicize(m[1]!));
  // embedded blackletter
  buf =
      buf.replaceAllMapped(RegExp(r'&&(.*?)&&'), (m) => text_frakturize(m[1]!));
  // embedded smallcaps
  buf = buf.replaceAllMapped(
      RegExp(r'\\\\(.*?)\\\\'), (m) => text_smallcapsify_pure(m[1]!));

  // preformatted text
  buf = buf.replaceAllMapped(RegExp(r'`=(.*)'), (m) => '${m[1]}');

  // normal verses
  buf = buf.replaceAllMapped(RegExp(r'5 THERE(.*)'),
      (m) => format_paragraph('5 THERE${m[1]!}', maxlinelen, false));
  buf = buf.replaceAllMapped(
      RegExp(r'`(.*)'), (m) => format_paragraph(m[1]!, maxlinelen, false));

  // chapter summaries with italic font
  buf = buf.replaceAllMapped(
      RegExp(r'-/~(.*)'), (m) => text_title(text_italicize(m[1]!)));
  buf = buf.replaceAllMapped(
      RegExp(r'-/\^(.*)'), (m) => text_title(text_italicize(m[1]!)));

  // titles with larger font
  buf = buf.replaceAllMapped(RegExp(r'\+\+\+\^(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\+\+\^(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\+\^(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\+~(.*)'), (m) => text_title(m[1]!));

  // titles with smaller font
  buf = buf.replaceAllMapped(
      RegExp(r'--\^(.*)'), (m) => text_smallcapsify_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'-\^(.*)'), (m) => text_title(m[1]!));

  // Written by stuff
  buf = buf.replaceAllMapped(RegExp(r'~  ❡ (.*)'), (m) => text_SH(m[1]!));
  buf =
      buf.replaceAllMapped(RegExp(r'~  Wr(.*)'), (m) => text_SH('Wr${m[1]!}'));
//text_SH(String str)

  // subtitles with normal font
  buf = buf.replaceAllMapped(RegExp(r'~(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\^(.*)'), (m) => text_title(m[1]!));

  // a special case
  buf = buf.replaceAll(RegExp(r'---\n\['), '---\n\n[');

  // horizontal rule
  String h_rule = ''.padLeft(maxlinelen - 1, '─');
  buf = buf.replaceAllMapped(RegExp(r'---'), (m) => h_rule);

  // remove the index markers
  buf = buf.replaceAll(RegExp(r'\[/(.*)\]\n'), '');

  format_type = old_format_type;
  return buf;
}

String text_echo(String horn) {
  return horn;
}

String markup_to_pure(String buf, int ftype) {
  int old_format_type = format_type;
  format_type = ftype;
  // embedded large italics
  buf = buf.replaceAllMapped(RegExp(r'///(.*?)///'), (m) => text_echo(m[1]!));
  // embedded italics
  buf = buf.replaceAllMapped(RegExp(r'//(.*?)//'), (m) => text_echo(m[1]!));
  // embedded blackletter
  buf = buf.replaceAllMapped(RegExp(r'&&(.*?)&&'), (m) => text_echo(m[1]!));
  // embedded smallcaps
  buf = buf.replaceAllMapped(RegExp(r'\\\\(.*?)\\\\'), (m) => text_echo(m[1]!));

  // preformatted text
  buf = buf.replaceAllMapped(RegExp(r'`=(.*)'), (m) => '${m[1]}');

  // normal verses
  buf = buf.replaceAllMapped(RegExp(r'5 THERE(.*)'),
      (m) => format_paragraph('5 THERE${m[1]!}', maxlinelen, false));
  buf = buf.replaceAllMapped(
      RegExp(r'`(.*)'), (m) => format_paragraph(m[1]!, maxlinelen, false));

  // chapter summaries with italic font
  buf = buf.replaceAllMapped(
      RegExp(r'-/~(.*)'), (m) => text_title(text_echo(m[1]!)));
  buf = buf.replaceAllMapped(
      RegExp(r'-/\^(.*)'), (m) => text_title(text_echo(m[1]!)));

  // titles with larger font
  buf = buf.replaceAllMapped(RegExp(r'\+\+\+\^(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\+\+\^(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\+\^(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\+~(.*)'), (m) => text_title(m[1]!));

  // titles with smaller font
  buf = buf.replaceAllMapped(RegExp(r'--\^(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'-\^(.*)'), (m) => text_title(m[1]!));

  // Written by stuff
  buf = buf.replaceAllMapped(RegExp(r'~  ❡ (.*)'), (m) => text_SH(m[1]!));
  buf =
      buf.replaceAllMapped(RegExp(r'~  Wr(.*)'), (m) => text_SH('Wr${m[1]!}'));
//text_SH(String str)

  // subtitles with normal font
  buf = buf.replaceAllMapped(RegExp(r'~(.*)'), (m) => text_title(m[1]!));
  buf = buf.replaceAllMapped(RegExp(r'\^(.*)'), (m) => text_title(m[1]!));

  // a special case
  buf = buf.replaceAll(RegExp(r'---\n\['), '---\n\n[');

  // horizontal rule
  String h_rule = ''.padLeft(maxlinelen - 1, '─');
  buf = buf.replaceAllMapped(RegExp(r'---'), (m) => h_rule);

  // remove the index markers
  buf = buf.replaceAll(RegExp(r'\[/(.*)\]\n'), '');

  // de-longSify everything for the pure text Bible
  buf = buf.replaceAll('ſ', 's');
  buf = buf.replaceAll('Æ', 'Ae');
  buf = buf.replaceAll('❡ ', '');
  buf = buf.replaceAll('¶ ', '');
  buf = buf.replaceAll('⛠ ', '');

  format_type = old_format_type;
  return buf;
}

/*
** routines marked with an arrow (-->) are called from parser
** this is the text parser so the routines are prefixed with text_
*/

/*
** --> render short title of current bible book
**   draw a horizontal rule
**   and add title to our book_list
*/

String text_short_title(String st) {
  String bar_char = '─';
  String rstr = ''.padLeft(maxlinelen - 1, bar_char);
  rstr = '\n\n$rstr\n';
  book_list.add('($st)');
  if (format_type == TEXT) {
    return rstr;
  } else {
    return '\n\n---\n';
  }
}

/*
** --> show a large title
*/

String text_large_title(String str) {
  if (format_type == TEXT) {
    return text_title(str);
  } else {
    return '+${text_title(str)}';
  }
}

/*
** --> show a title in regular print
*/

String text_title(String st) {
  if (format_type != TEXT && runeLength(st) > 80) {
    return format_hanging_no_center(st, 0, 2);
  }
  return format_hanging(st, 0, 2);
}

/*
** --> render chapter title
*/

String text_chapter_title(String name, String number) {
  String prefix = '\n\n';
  String middle = '$name ${roman_str(number)}.';
  String suffix = '\n\\ChapterHeader\n';

  return '$prefix${text_title(middle)}$suffix';
}

/*
** --> render chapter header
*/

int hdr_idx = 0;

String text_chapter_header() {
  String rstr = '';
  if (hdr_idx < chapter_header_list.length) {
    rstr = '${chapter_header_list[hdr_idx++]}\n';
  }
  if (format_type == TEXT) {
    return text_italicize('\n$rstr');
  } else {
    return '\n-/$rstr';
  }
}

/*
** --> render the first verse of a chapter
**
**  apply typographical rules:
**    usually we uppercase the first word, unless it has just one character
**      in that case we uppercase both the first and the second word
**    if the first word of a first verse has more than one capital letter
**      we consider it to be preformatted
**    same deal if the first word has one letter and the second word has
**      more than one capital
**    we need to deal with preformatting because there are exceptions
*/

String text_first_verse(String w0, String w1, String w2, String w3) {
  rverse = '$w1$w2$w3'; // leave string alone by default
  // if there is more than one capital letter in the word we want to change
  //   it's preformatted text and we need to leave it alone
  if (w1.length == 1) {
    // first word a single letter -- capitalize second word
    if (countCaps(w3) == 0) {
      rverse = '$w1$w2${w3[0].toUpperCase()}${w3.substring(1)}';
    }
  } else if (w1.length < 6) {
    // first word less than 6 chars -- capitalize the whole thing
    if (countCaps(w1) == 1) {
      rverse = '${w1.toUpperCase()}$w2$w3';
    }
  } else {
    // first word 6 chars or longer -- capitalize first two letters
    if (countCaps(w1) == 1) {
      rverse = '${w1.substring(0, 2).toUpperCase()}${w1.substring(2)}$w2$w3';
    }
  }
  String verse_message = '$verse_count -- $w1|$w2|$w3 --> $rverse';
  update_verse_count(verse_message);
  return rverse;
}

int countCaps(String teststr) {
  int caps = 0;
  List<String> charlist = runeSplit(teststr);
  List<String> caplist = runeSplit('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  for (String char in charlist) {
    if (caplist.contains(char)) {
      caps++;
    }
  }
  return caps;
}

/*
** --> render the other verses in a chapter
*/

String text_verse(String verse) {
//  return '\n  $verse ';
  return '\n  $verse ';
}

/*
** --> render small caps
*/

String text_smallcapsify(String str) {
  if (str.toLowerCase() == 'jehovah') return str.toUpperCase();
  if (str.toLowerCase() == 'jah') return str.toUpperCase();
  final lstr = runeSplit(str.toLowerCase());
  String rstr = str[0];
  if (format_type == TEXT) {
    for (String ch in lstr.sublist(1)) {
      rstr += smallcaps[ch]!;
    }
    return rstr;
  } else {
    rstr += str.substring(1).toLowerCase();
    return '\\\\$rstr\\\\';
  }
}

String text_smallcapsify_pure(String str) {
  if (str.toLowerCase() == 'lord') return text_smallcapsify(str);
  if (str.toLowerCase() == 'lord’s') return text_smallcapsify(str);
  if (str.toLowerCase() == 'god') return text_smallcapsify(str);
  if (str.toLowerCase() == 'jehovah') return str.toUpperCase();
  if (str.toLowerCase() == 'jah') return str.toUpperCase();
  final lstr = runeSplit(str.toLowerCase());
  String rstr = '';
  for (String ch in lstr) {
    rstr += smallcaps[ch]!;
  }
  return rstr;
}

String text_smallcapsify_title(String str) {
  String ch = '';
  String teststr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ';
  final lstr = runeSplit(str);
  String rstr = '';

  for (ch in lstr) {
    if (!teststr.contains(ch)) return text_title(str);
    rstr += smallcaps[ch.toLowerCase()]!;
  }
  return text_title(rstr);
}

String text_frakturize(String str) {
  final lstr = runeSplit(str);
  String rstr = '';
  for (String ch in lstr) {
    rstr += fraktur[ch]!;
  }
  return rstr;
}

/*
** --> render italics
*/

String text_italicize(String str) {
  // in old texts, can't italicize small caps -- make them big caps
  str = str.replaceAllMapped(
      RegExp(r'\\\\(.*?)\\\\'), (m) => m[1]!.toUpperCase());
  if (format_type == TEXT) {
    final lstr = runeSplit(str);
    String rstr = '';
    for (String ch in lstr) {
      rstr += italics[ch]!;
    }
    return rstr;
  } else {
    return '//$str//';
  }
}

/*
** --> render \SH
*/

String text_SH(String str) {
  if (str[0] == '[') return ''; // ignore these
  // account for the missing pilcrow
  if ((str.contains('Ephesians') || str.contains('Epheſians')) &&
      str.contains('Tychicus')) {
    str = format_hanging_no_center(str, 2, 2);
  } else {
    str = format_hanging_no_center('❡ $str', 2, 2);
  }
  return '\n\n$str\n\n';
}

/*
** ──────────────────────────────────────────────────
*/

/*
** center text on a line of width maxlinelen
*/

String center_para(String para) {
  if (para == '' || para == ' ') return para;
  int prefix = (maxlinelen - runeLength(para) - 1) ~/ 2;
  String pad = '';
  while (prefix-- > 0) {
    pad += ' ';
  }
  return pad + para;
}

/*
** center text between bars
*/

String bar_center_para(String para) {
  String bar_char = '─';
  para = para.replaceFirst('(', '[');
  // a little dipsy-doodle here to account for Esther (Greek)
  para = para.replaceFirst('))', '>');
  para = para.replaceFirst(')', ']');
  para = para.replaceFirst('>', ')]');
  String rstr = '';
  if (para == '' || para == ' ') return para;
  int prefix = (maxlinelen - runeLength(para) - 1) ~/ 2;
  int postfix = prefix;
  String pad = '';
  while (prefix-- > 0) {
    pad += bar_char;
  }
  rstr = pad + para;
  while (postfix-- > 0) {
    rstr += bar_char;
  }
  return rstr;
}

/*
** format paragraph with hanging indent
**   if paragraph ends up with 1 or 2 lines -- center them
*/

String format_hanging(String para, int indent, int hang) {
  String indent_str = '';
  String hang_str = '';

  if (format_type != TEXT) {
    return '^${para.padLeft(indent)}';
  }

  int linelen = maxlinelen - indent - hang - 1;
  hang += indent;
  para = format_paragraph(para, linelen, false); // was true
  List<String> paralist = para.split('\n');
  if (paralist.length == 1) {
    para = center_para(para);
    return (para);
  }
  if (paralist.length == 2) {
    para = center_para(paralist[0]);
    para += '\n${center_para(paralist[1])}';
    return (para);
  }
  if (paralist.length == 3) {
    if (paralist[2] == '') {
      para = center_para(paralist[0]);
      para += '\n${center_para(paralist[1])}';
      return (para);
    }
  }
  while (indent-- > 0) {
    indent_str += ' ';
  }
  while (hang-- > 0) {
    hang_str += ' ';
  }
  para = indent_str + para;
  para = para.replaceAll('\n', '\n$hang_str');
  return para;
}

/*
** format paragraph with hanging indent
**   don't center if only 1 or 2 lines
*/

String format_hanging_no_center(String para, int indent, int hang) {
  String indent_str = '';
  String hang_str = '';

  if (format_type != TEXT) {
    if (para == '\n' || para == '\n ') return para;
    String pad = ''.padLeft(indent);
    return '~$pad$para';
  }

  int linelen = maxlinelen - indent - hang - 1;
  hang += indent;
  para = format_paragraph(para, linelen, false); // was true
  while (indent-- > 0) {
    indent_str += ' ';
  }
  while (hang-- > 0) {
    hang_str += ' ';
  }
  para = indent_str + para;
  para = para.replaceAll('\n', '\n$hang_str');
  return para;
}

/*
** make a list of words from a string
*/
List<String> make_word_list(String para) {
  final lstr = runeSplit(para);
  List<String> wordlist = [];
  String curword = '';

  // put the words into a list
  for (String ch in lstr) {
    if (ch != ' ') {
      curword += ch;
    }
    if (ch == ' ' || ch == '\n') {
      if (curword != '') {
        wordlist.add(curword);
        curword = '';
      }
    }
  }
  if (curword != '') wordlist.add(curword);
  return wordlist;
}

/*
** make a list of tokens from a string
*/
List<String> make_token_list(String para) {
  final lstr = runeSplit(para);
  List<String> wordlist = [];
  String curword = '';

  // put the words into a list
  for (String ch in lstr) {
    if (ch != ' ' && ch != '\n') {
      curword += ch;
    } else {
      if (curword != '') {
        wordlist.add(curword);
        curword = '';
      }
      wordlist.add(ch);
    }
  }
  return wordlist;
}

/*
** format paragraph -- the hard way
*/

String format_paragraph(String para, int maxlen, bool longSify) {
  final lstr = runeSplit(para);
  List<String> wordlist = [];
  String curword = '';
  String nextword = '';
  String wordpair = '';
  int spacecount = 0;
  String suffix = '';

  if (para.isNotEmpty && para[para.length - 1] == '\n') {
    suffix = '\n';
    para = para.substring(0, para.length - 1);
  }

  // count up the leading spaces
  for (String ch in lstr) {
    if (ch != ' ') break;
    ++spacecount;
  }

  wordlist = make_word_list(para);

// here all the words are in wordlist
// good time to long-S-ify

  if (longSify) {
    wordlist = longSify_list(wordlist);
  }

  // prefix the new line with the appropriate number of spaces
  int linelen = 0;
  String newpara = '';
  for (int i = 0; i < spacecount; i++) {
    newpara += ' ';
    linelen++;
  }

  int idx = 0;
  for (curword in wordlist) {
    if (curword == '\n') {
      newpara += '\n';
      idx++;
      continue;
    }

    // don't allow a line to end on a (verse) number
    // this can happen in the chapter headers
    if (int.tryParse(curword) != null) {
      if (idx < wordlist.length - 1) {
        nextword = wordlist[idx + 1];
        wordpair = '$curword $nextword';
        if (runeLength(wordpair) + linelen > maxlen) {
          newpara += '\n$curword ';
          linelen = runeLength(curword) + 1;
          idx++;
          continue;
        }
      }
    }

    if (runeLength(curword) + linelen > maxlen) {
      newpara += '\n$curword ';
      linelen = runeLength(curword) + 1;
    } else {
      newpara += '$curword ';
      linelen += runeLength(curword) + 1;
    }
    idx++;
  }

  // there should only be one of these -- at the end
  newpara = newpara.replaceFirst('\n ', '\n');
  return newpara + suffix;
}

/*
** long-S-ify a list of words
*/

List<String> longSify_list(List<String> Slist) {
  List<String> longSlist = [];

  for (String word in Slist) {
//    longSlist.add(word);
    longSlist.add(longSify(word));
  }

  return longSlist;
}

/*
** long-S-ify a word
**
** for example, we want:
**   darkness -> darkneſs -- no long S at end of word (Gen 1:2)
**   ass's -> aſs's -- apostrophe rule (Gen 49:11)
**   satisfied -> ſatisfied -- no long S before f (Exodus 15:9)
**   inconsistent long S after f -- these are the only 3 words I could find
**     selfsame -> ſelfſame -- long S after f OK (Genesis 7:13) (17 of these)
**     offspring -> offspring -- but sometimes not OK (Job 5:25) (16 of these)
**     offscouring -> offſcouring -- OK this time (Lamentations 3:45) (2 of these)
**   husband -> huſband - long S before b OK (Genesis 3:6)
**   skins -> ſkins - long S before k OK (Genesis 3:21)
**   
** I'm tempted to think there's a double f rule but offscouring kinda
**   upsets that idea. Offspring would fit though.
*/

String longSify(String Sword) {
  // things you can't have a long S before
  List<String> noSlist = [
    ' ',
    'f',
    '𝑓',
    "'",
    '’',
    '"',
    '“',
    '”',
    ',',
    '.',
    ':',
    ';',
    '?',
    '!',
    '/', // embedded italics markup
    '\\', // embedded smallcaps markup
    ']', // index entry
    '\n'
  ];

  // these words don't get a long S -- just because...

  List<String> exceptions = [
    'offspring',
    '𝑜𝑓𝑓𝑠𝑝𝑟𝑖𝑛𝑔',
    'Offspring',
    '𝑂𝑓𝑓𝑠𝑝𝑟𝑖𝑛𝑔'
  ];

  // we assume the junk is at the end -- all in one place
  //   don't remove single quotes or apostrophes
  String sanitized = Sword.replaceFirst(RegExp(r'[ .,:;?!"“”/\n]+'), "");
  // word in our exception list -- just return the word unchanged
  if (exceptions.contains(sanitized)) return Sword;

  // put spaces at the end, so we don't have to keep track of string length
  Sword += '  ';
  List<String> Schars = runeSplit(Sword);
  int idx = -1;
  for (String char in Schars) {
    ++idx;
    if (char == ' ') break;
    if (noSlist.contains(Schars[idx + 1])) continue;
    if (char == 's') {
      Schars[idx] = 'ſ';
    } else if (char == '𝑠') {
      Schars[idx] = iLongS; // esh or integral sign -- see unicode_fonts.dart
    }
  }

  // remember to remove those two spaces
  Schars.removeLast();
  Schars.removeLast();

  String rword = Schars.join('');
  return rword;
}

/*
** format the first word(s) of the first verse in a chapter
**
** try to follow the original typographical rules...
*/

int verse_count = 1;
String rverse = '';
List<String> change_list = [];

update_verse_count(String verse_message) {
  change_list.add(verse_message);
//  print(verse_message);
  if (verse_count == 1362) {
    write_file('./output/first_verse_edits.txt', change_list.join('\n'));
  }
  ++verse_count;
}
/*
** romanencode(n) -- encode roman numerals in 'standard' form
**
** may need to tweak since some texts we are interested in use 
** non-standard form e.g. IIII or iiii instead of IV
*/

String roman_str(String? x) {
  return x != null ? romanencode(int.parse(x)) : '';
}

String romanencode(int n) {
  String result = '';
  const roman = [
    [1000, 'M'],
    [900, 'CM'],
    [500, 'D'],
    [400, 'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [9, 'IX'],
    [5, 'V'],
    [4, 'IV'],
    [1, 'I'],
  ];

  if (n >= 4000) return 'ROMAN NUMERAL OVERFLOW';

  for (List l in roman) {
    while (n >= l[0]) {
      n -= l[0] as int;
      result += l[1];
    }
  }

  return result;
}
