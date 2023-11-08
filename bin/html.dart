// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names

/*
** HTMLify a marked up buffer
**
** Of course we made up a new markup language
**
**   it's line oriented
**   these formatting commands must be at beginning of line
**   (implement as needed)
**
** `   prefix means normal text -- a paragraph if you like
** ^   prefix means normal text centered
** ~   prefix means normal text with hanging indent
** /   prefix means italic text
** /^  prefix means italic text centered
** /~  prefix means italic text with hanging indent
** 
** +   prefix to the above means larger text (titles with larger font)
** -   prefix means smaller text (summaries with italic font)
**
** --- gets a horizontal rule
**
** Embedded commands
**   must be complete within current line
**   nesting and escaping don't work
**
** //text// make text italic
** ///text/// make text title sized italic
** \\text\\ make text small caps - keep first char make the rest lower case
** ||text|| text is a footnote
** 
** embedded '\u200E' gets a left to right marker
** embedded hebrew gets a nice hebrew font
**
** embedded ❡ ¶ ⛠ are large, medium, and small pilcrows
**   convert to pilcrows of one style but different sizes
*/

import 'file_io.dart';
import 'unicode_fonts.dart';
import 'rune_stuff.dart';

Map<String, String> reverse_italics =
    Map.fromIterables(alpha_italics_short_chars, alpha_normal_short_chars);

String HTMLify(String buf, String cssfile) {
  String prefix = '<!-- KJV 1769 Bible -->\n\n';
  prefix += '<!DOCTYPE html>\n';
  prefix += '<html lang="en">\n';
  prefix += '  <head>\n';
  prefix += '  <meta charset="UTF-8">';
  prefix +=
      '  <meta name="viewport" content="width=device-width, initial-scale=1.0">';
  prefix += '  <title> KJV 1769</title>\n';
  prefix += '</head>\n';
  prefix += '<body>\n';
  prefix += '<section>\n';

  prefix += '<link rel="stylesheet" href="$style_path/$cssfile">';

//  prefix += '<style>';
//  prefix += read_file('$style_path/$cssfile');
// prefix += '</style>';

  String suffix = '</section>\n';
  suffix += '</body>\n';
  suffix += '</html>\n';

  // replace unicode italics with marked large italics (a title)
  buf = buf.replaceAllMapped(
      RegExp('([$alpha_italics_short]+)'), (m) => rev_italics(m[1]!));
  buf = buf.replaceAll('/// ///', ' ');

  // process horizontal rule
  buf = buf.replaceAllMapped(RegExp(r'---'), (m) => '<p> </p><hr>');

  // process index string
  // Here we assume the first char inside the index square brackets is a slash.
  //   This kinda forces the search character to be a slash.
  //   Why this? well, 1 John 2:23 has square brackets. They are around a
  //   single word -- [but]. These are the only square brackets left in
  //   the text. One pair. Pretty cool huh?
  buf = buf.replaceAllMapped(RegExp(r'\[/(.*)\]'),
      (m) => '<p class = index>/${delongSify(m[1]!)}</p>');

  // pilcrow gymnastics
  //   first for the "Written by" stuff at the end of some NT books
  buf = buf.replaceAll(
      '~  ❡ ', '<p class = padfour>❡<span class = padone></span>');
  buf = buf.replaceAll('~  Wr', '<p class = padfour>Wr'); // was <padfourb>

  // more gymnastics for the regular pilcrows
  //   delete space after pilcrow and use pilcrow padding to ...
  //   ... tie first word of verse to pilcrow
  //   also tie pilcrow to verse number with a smaller amount of padding ...
  //   ... by deleting space before pilcrow
  buf = buf.replaceAll(' ❡ ', '<span class = pil_lg>¶</span>');
  buf = buf.replaceAll('❡ ', '<span class = pil_lg>¶</span>');
  buf = buf.replaceAll(' ⛠ ', '<span class = pil_sm>¶</span>');
  buf = buf.replaceAll(' ¶ ', '<span class = pil_med>¶</span>');

  // a little extra space for punctuation that had extra space back in the day
  buf = buf.replaceAll(';', '<span class = punc>;</span>');
  buf = buf.replaceAll(':', '<span class = punc>:</span>');
  buf = buf.replaceAll('!', '<span class = punc>!</span>');
  buf = buf.replaceAll('?', '<span class = punc>?</span>');
  buf = buf.replaceAll(')', '<span class = rparen>)</span>');
  buf = buf.replaceAll('(', '<span class = lparen>(</span>');

  // a little extra space in chapter numbers
  buf = buf.replaceAll('CHAP.', 'CHAP.&nbsp');
  // a little extra space in Psalm chapter numbers
  buf = buf.replaceAll('PSAL.', 'PSAL.&nbsp');

  // a little extra space after hebrew chars
  buf = buf.replaceAllMapped(RegExp(r'(.*)([\u0590-\u05FF])(.*)'),
      (m) => '${m[1]}${m[2]}&nbsp${m[3]}');

  // preformatted text
  buf = buf.replaceAllMapped(RegExp(r'`=(.*)'), (m) => '<pre>${m[1]}</pre>');

  // surround lines with paragraph markers
  // normal verses
  buf = buf.replaceAllMapped(RegExp(r'5 THERE(.*)'),
      (m) => '<p class = dropcap2>THERE${m[1]}</span></p>');
  buf = buf.replaceAllMapped(RegExp(r'`(.*)'), (m) => '<p>${m[1]}</p>');

  // drop cap first letter of a chapter
  buf = buf.replaceAllMapped(RegExp(r'<p>([ABCDEFGHIKLMNOPRSTUVWXYZ])'),
      (m) => '<p class = dropcap2>${m[1]}');
  buf = buf.replaceAllMapped(
      RegExp(r'<p>([JQ])'), (m) => '<p class = dropcap2j>${m[1]}');
  // 'J' and 'Q' might need a little extra padding on the bottom
  buf = buf.replaceAllMapped(RegExp(r'<p>//([ABCDEFGHIKLMNOPRSTUVWXYZ])'),
      (m) => '//<p class = dropcap2i>${m[1]}');
  buf = buf.replaceAllMapped(
      RegExp(r'<p>//([JQ])'), (m) => '//<p class = dropcap2ji>${m[1]}');

  // now tie the first word or symbol of a verse to verse numbers ...
  // ... that have no pilcrow

  buf = buf.replaceAllMapped(
      RegExp(r'<p>  (\d+) '), (m) => '<p><span class = vnum>${m[1]}</span>');
  buf = buf.replaceAllMapped(
      RegExp(r'<p>  (\d+)<'), (m) => '<p><span class = vnump>${m[1]}</span><');

  // chapter summaries with italic font
  buf = buf.replaceAllMapped(RegExp(r'-/~(.*)'),
      (m) => html_summary_hang(m[1]!)); //<p class = sum_hang>${m[1]}</p>');
  buf = buf.replaceAllMapped(
      RegExp(r'-/\^(.*)'),
      (m) =>
          html_summary_center(m[1]!)); //'<p class = sum_center>${m[1]}</p>');

  // titles with larger font
  buf = buf.replaceAllMapped(RegExp(r'\+\+\+\^(.*)'),
      (m) => '<p class = title_center_huge>${m[1]}</p>');
  buf = buf.replaceAllMapped(RegExp(r'\+\+\^(.*)'),
      (m) => '<p class = title_center_large>${m[1]}</p>');
  buf = buf.replaceAllMapped(
      RegExp(r'\+\^(.*)'), (m) => '<p class = title_center>${m[1]}</p>');
  buf = buf.replaceAllMapped(
      RegExp(r'\+~(.*)'), (m) => '<p class = title_hang>${m[1]}</p>');

  // titles with smaller font
  buf = buf.replaceAllMapped(
      RegExp(r'--\^(.*)'), (m) => '<p class = title_center_tiny>${m[1]}</p>');
  buf = buf.replaceAllMapped(
      RegExp(r'-\^(.*)'), (m) => '<p class = title_center_small>${m[1]}</p>');

  // subtitles with normal font
  buf = buf.replaceAllMapped(
      RegExp(r'~(.*)'), (m) => '<p class=hang> ${m[1]}<p>');
  buf = buf.replaceAllMapped(
      RegExp(r'\^(.*)'), (m) => '<p class=center> ${m[1]}<p>');

/*
** handle embedded font stuff
*/

  // embedded large italics
//  buf = buf.replaceAllMapped(
//      RegExp(r'///(.*?)///'), (m) => '///${split_italics(m[1]!, '///')}///');
  buf = buf.replaceAllMapped(
      RegExp(r'///(.*?)///'), (m) => italicize_large(m[1]!));

  // embedded italics
  buf = buf.replaceAllMapped(
      RegExp(r'//(.*?)//'), (m) => '//${split_italics(m[1]!, '//')}//');
  buf = buf.replaceAllMapped(RegExp(r'//(.*?)//'), (m) => italicize(m[1]!));

  // embedded blackletter
  buf = buf.replaceAllMapped(
      RegExp(r'&&(.*?)&&'), (m) => '<span class = blackletter>${m[1]}</span>');

  // embedded smallcaps
  buf = buf.replaceAllMapped(
      RegExp(r'\\\\(.*?)\\\\'), (m) => html_smallcapsify(m[1]!));

  String html = '$prefix$buf$suffix';

  return html;
}

String delongSify(String str) {
  str = str.replaceAll('ſ', 's');
  return str;
}

String split_italics(String str, String term) {
  List<String> lstr = runeSplit(str);
  String rstr = '';
  List<String> lpunc = [';', ':', '!', '?'];

  for (String ch in lstr) {
    if (lpunc.contains(ch)) {
      rstr += '$term$ch$term';
    } else {
      rstr += ch;
    }
  }
  return rstr;
}

String span_numbers(String str) {
  String rstr = str.replaceAllMapped(
      /* normal verse numbers in header */
      RegExp(r'(\d+) '),
      (m) => '<span class = vnumh>${m[1]!}</span>');
  rstr = rstr.replaceAllMapped(
      /* verse numbers followed by comma */
      RegExp(r'(\d+),'),
      (m) => '<span class = number>${m[1]!}</span>,');

  return rstr;
}

String html_summary_hang(String str) {
  String rstr = '<p class = sum_hang>${span_numbers(str)}</p>';
  return rstr;
}

String html_summary_center(String str) {
  String rstr = '<p class = sum_center>${span_numbers(str)}</p>';
  return rstr;
}

String html_smallcapsify(String str) {
  if (str.toLowerCase() == 'jah') return str.toUpperCase();
  if (str.toLowerCase() == 'jehovah') return str.toUpperCase();
  return '<small>$str</small>';
}

String rev_italics(String str) {
  List<String> strl = runeSplit(str);
  str = '///';
  for (String ch in strl) {
    if (!reverse_italics.containsKey(ch)) {
      print('@@$ch@@'); // an error message of sorts
    } else {
      str += reverse_italics[ch]!;
    }
  }
  str += '///';
  return str;
}

String italicize(String str) {
  // a little extra padding if string starts with these
  if (str[0] == 'ſ') {
    return '<i><span class=longS>$str</span></i>';
  } else if (str[0] == 'f') {
    return '<i><span class=longF>$str</span></i>';
  } else {
    return '<i>$str</i>';
  }
}

String italicize_large(String str) {
  // a little extra padding if string starts with these
  if (str[0] == 'ſ') {
    return '<i class= title_italic><span class=longS>$str</span></i>';
  } else if (str[0] == 'f') {
    return '<i class = title_italic><span class=longF>$str</span></i>';
  } else {
    return '<i class = title_italic>$str</i>';
  }
}
