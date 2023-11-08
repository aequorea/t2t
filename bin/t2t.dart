// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names
//   ignore_for_file: prefer_interpolation_to_compose_strings

/*
** need '𝑇ℎ𝑒 END 𝑜𝑓 𝑡ℎ𝑒 PROPHETS.' and maybe something decorative
**   '𝑇ℎ𝑒 END 𝑜𝑓 𝑡ℎ𝑒 APOCRYPHA.'
**
** title pages -- even for 'APOCRYPHA.'
*/

/*
**  t2t.dart -- tex to text
**
**  Fixed typo -- Revelation 18:22 has the missing words -- revert??
**  Unfixed typos: 
**    Deu 9 header -- 'dissaudeth' (folio) -> 'dissuadeth' (quarto)
**    Heb 10 header -- 'sorfeiting' should be 'forfeiting'
**
**  pilcrows...
**
**  ⛠ -- 'RESTRICTED LEFT ENTRY-1'
**  ¶ -- 'PILCROW SIGN'
**  ❡ -- 'CURVED STEM PARAGRAPH SIGN ORNAMENT'
**
**  ❡ ¶ ⛠ -- large, medium, and small...
*/

import 'format_text.dart';
import 'parse_tex.dart';
import 'html.dart';

// import 'dart:io';
import 'file_io.dart';

void main(List<String> arguments) {
  final sw = Stopwatch()..start();
  //  test_all();
  format_type = HTML;
//  format_type = ALL;

  String markup_file = '$output_path/Bible_1769_markup.txt';
  String markup_longS = '$output_path/Bible_1769_markup_longS.txt';

  String oldtext_bible = '$output_path/Bible_1769_oldtext.txt';
  String text_bible = '$output_path/Bible_1769_text.txt';
  String puretext_bible = '$output_path/Bible_1769_puretext.txt';

  String original_bible = '$output_path/Bible_1769_original.html';
  String modern_bible = '$output_path/Bible_1769_modern.html';

  if (format_type == HTML || format_type == MARKUP || format_type == ALL) {
    print('Generating markup Bible...');
    String buf = generate_Bible(MARKUP);
    write_file(markup_file, buf);

    print('LongSification...');
    buf = read_file(markup_file);
    List<String> wordlist = make_token_list(buf);
    wordlist = longSify_list(wordlist);
    buf = wordlist.join('');

    write_file(markup_longS, buf);

    print('\n${sw.elapsedMilliseconds / 1000} seconds.\n');
  }

  if (format_type == HTML || format_type == ALL) {
    print('Generating HTML Bibles...');
    String buf = read_file(markup_longS);
    buf = add_external_markup(buf, 'KJV_1769_bookcodes.txt');
    String html = HTMLify(buf, 'KJV_1769_original.css');
    write_file(original_bible, html);

    buf = read_file(markup_longS);
    buf = add_external_markup(buf, 'KJV_1769_bookcodes.txt');

    // de-longSify everything for the modern Bible
    buf = buf.replaceAll('ſ', 's');
    html = HTMLify(buf, 'KJV_1769_modern.css');
    write_file(modern_bible, html);

    print('Generating text from markup Bible...');
    buf = read_file(markup_longS);
    buf = add_external_markup(buf, 'KJV_1769_books.txt');
    buf = markup_to_text(buf, TEXT);

    // remove trailing spaces (again)
    buf = happy_trail(buf);
    write_file(text_bible, buf);

    print('Generating pure text from markup Bible...');
    buf = read_file(markup_longS);
    buf = add_external_markup(buf, 'KJV_1769_books.txt');
    buf = markup_to_pure(buf, TEXT);

    // remove trailing spaces (again)
    buf = happy_trail(buf);
    write_file(puretext_bible, buf);

    print('\n${sw.elapsedMilliseconds / 1000} seconds.\n');
  }

  if (format_type == TEXT || format_type == ALL) {
    print('Generating text Bible using old method...');
    String buffer = generate_Bible(TEXT);
    String markup_buf = add_external_markup('', 'KJV_1769_books.txt');
    String processed_buf = markup_to_text(markup_buf, TEXT);
    buffer = processed_buf + buffer;

    // remove trailing spaces (again)
    buffer = happy_trail(buffer);
    write_file(oldtext_bible, buffer);

    print('\n${sw.elapsedMilliseconds / 1000} seconds.\n');
  }
}

String happy_trail(String trail) {
  trail = trail.replaceAll(' \n', '\n');
  trail = trail.replaceAll('\n\n\n', '\n\n');
  trail = trail.replaceAll('\n\n\n', '\n\n');

  return trail;
}

String add_external_markup(String buf, String booklist) {
  buf = read_file('$new_path/KJV_1769_title.txt') +
//      read_file('$new_path/KJV_1769_intro.txt') +
//      read_file('$new_path/$booklist') +
      buf;

  buf = buf.replaceFirst('earth with a curſe.\n\n---',
      'earth with a curſe.' + read_file('$new_path/KJV_1769_apotitle.txt'));

  buf = buf.replaceFirst(
      'And here ſhall be an end.\n\n---',
      'And here ſhall be an end.' +
          read_file('$new_path/KJV_1769_nttitle.txt'));

  buf = buf.replaceFirst(
      '21 The grace of our Lord Jeſus Chriſt //be// with you all. Amen.',
      '21 The grace of our Lord Jeſus Chriſt //be// with you all. Amen.' +
          read_file('$new_path/KJV_1769_end.txt'));

//  buf += read_file('$new_path/KJV_1769_colophon.txt');

  return buf;
}

/*
** generate the Bible text
*/

String generate_Bible(int ftype) {
  String buffer = '';
  int old_format_type = format_type;
  format_type = ftype;

/*
**  the text (TEX)
*/

  print('Parsing TEX...');
  buffer = parse_tex_init(buffer);
  buffer = parse_tex_paragraphs(buffer);
  buffer = parse_tex_verses(buffer);
  buffer = parse_tex_fonts(buffer);
  buffer = parse_tex_chapters(buffer);
  buffer = parse_tex_titles(buffer);
  buffer = parse_tex_other(buffer);
  buffer = parse_tex_cleanup(buffer);

  if (format_type != TEXT) {
    // de-longSify the index entries -- not pretty
    buffer = buffer.replaceAllMapped(
        RegExp(r'\[(.*)\]'), (m) => '[${m[1]!.replaceAll('ſ', 's')}]');
    // reformat and markup the verses -- also not so pretty
    buffer =
        buffer.replaceAllMapped(RegExp(r'\n  (\d+)'), (m) => '\n`  ${m[1]}');
    buffer = buffer.replaceAllMapped(
        RegExp(r'\n([ABCDEFGHIJKLMNOPQRSTUVWXYZ/\\]+)'), (m) => '\n`${m[1]}');
  } else {
    print('Formatting text...');
    // send individual paragraphs to format_paragraph()
    buffer = buffer.replaceAllMapped(RegExp(r"([\s\S]*?)\n"),
        (m) => '${format_paragraph(m[1]!, maxlinelen, true)}\n');
  }
  format_type = old_format_type;
  return buffer;
}
