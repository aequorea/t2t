// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names
//   ignore_for_file: prefer_interpolation_to_compose_strings

import 'edit_source.dart';
import 'format_text.dart';
import 'unicode_fonts.dart';
import 'file_io.dart';
import 'index.dart';

/*
** initialization
*/

String parse_tex_init(String buffer) {
  current_book = 0;
  init_charwidths();

  // make list of chapter headers
  String chapter_headers = read_file('$new_path/$chapter_header_file');
  final re = RegExp(r'(Chapter|Psalm) \d+([\s\S]+?)\n\n');
  final matches = re.allMatches(chapter_headers);
  for (final m in matches) {
    String cur = m[2]!;
    cur = cur.replaceAll('\n   ', '\n');
    cur = cur.replaceAll('\n  ', '\n');
    cur = cur.replaceAll('-\n', '');
    cur = cur.replaceAll('\n', ' ');
    if (cur[0] == ' ') cur = cur.substring(1);
    cur += '\n';
    cur = text_title(cur);
    chapter_header_list.add(cur);
  }

  // get the list of files
  buffer = read_file('$input_path/$in_file');

  // edit the file list
  //   remove front matter and reorder apocrypha to match 1769
  buffer = editFileList(buffer);

  // read in the files
  buffer = buffer.replaceAllMapped(RegExp(r'\\input\{([\s\S]+?)\}'),
      (m) => read_file('$input_path/${m[1]}.tex'));

  // turn the buffer into one long line...
  buffer = buffer.replaceAll('\n', ' ');
  // ...and remove double spaces
  buffer = buffer.replaceAll('  ', ' ');

  print('Editing text...');
  buffer = doStructuralEdits(buffer);
  numedits = 0;
  buffer = doSpelling(buffer);
  buffer = doMisprints(buffer);
  print('$numedits changes (spelling and misprints)...');

  print('Doing paragraph markers...');
  String paragraphs_markers_raw = read_file('$new_path/$paragraph_file');
  buffer = redo_paragraph_markers(buffer, paragraphs_markers_raw);

  print('Preformatting some verse ones and subtitles...');
  buffer = preformat_first_verse(buffer);
  buffer = preformat_subtitles(buffer);

  write_source_file('$output_path/Bible_source.txt', buffer);

  if (format_type != TEXT) {
    print('Indexing...');
    buffer = gen_index(buffer);
  }
  return buffer;
}

/*
** paragraphs
*/

String parse_tex_paragraphs(buffer) {
  // ignore Tex paragraph markers
  buffer = buffer.replaceAllMapped(
      RegExp(r"\{\\PP ([\s\S]+?)\\par \}"), (m) => '${m[1]}');

  // ignore \Q -- it's like an end of line token used in Psalms
  buffer = buffer.replaceAll(RegExp(r"\{\\Q "), '');

  // ignore \BB -- they seem to be a kind of paragraph marker
  //   that usually come before {\Q
  buffer = buffer.replaceAll(RegExp(r"\{\\BB \\par \}"), '');

  return buffer;
}

/*
** verses
*/

String parse_tex_verses(String buffer) {
  write_file('./output/unversed.txt', buffer);

  // Ignore verse number of first verse and convert the first word
  //  of the verse to upper case -- well sort of...
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\VerseOne\{(\d+)\}(\w+)([, ]+\{\\ADD\{)(\w+)"),
      (m) => text_first_verse(m[1]!, m[2]!, m[3]!, m[4]!));

  buffer = buffer.replaceAllMapped(
      RegExp(r"\\VerseOne\{(\d+)\}(\w+)([, ]+\{\\ND\{ )(\w+)"),
      (m) => text_first_verse(m[1]!, m[2]!, m[3]!, m[4]!));

  buffer = buffer.replaceAllMapped(
      RegExp(r"\\VerseOne\{(\d+)\}(\w+)([, ]+)(\w+)"),
      (m) => text_first_verse(m[1]!, m[2]!, m[3]!, m[4]!));

  // handle verse one with words of Jesus
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\VerseOne\{(\d+)\}\{\\WJ\{(\w+)([, ]+)(\w+)"),
      (m) => '{\\WJ{${text_first_verse(m[1]!, m[2]!, m[3]!, m[4]!)}');

  // handle verse one with additions (italics)
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\VerseOne\{(\d+)\}\{\\ADD\{(\w+)([, \{\}\\]+)(\w+)"),
      (m) => '{\\ADD{${text_first_verse(m[1]!, m[2]!, m[3]!, m[4]!)}');

  // Handle the case where the first word is name of deity
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\VerseOne\{(\d+)\}\{\\ND\{ (\w+)\}\}([, ]+)(\w+)"),
      (m) => text_first_verse(m[1]!, m[2]!, m[3]!, m[4]!));

  // process the other verses
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\VS\{(\d+)\}"), (m) => text_verse(m[1]!));

  write_file('./output/versed.txt', buffer);

  return buffer;
}

/*
** render fonts
*/

String parse_tex_fonts(String buffer) {
  // deify the name of the Deity
  // must do this before italics
  buffer = buffer.replaceAllMapped(
      RegExp(r"\{\\ND\{ ?([\s\S]+?)\}\}"), (m) => text_smallcapsify(m[1]!));

  // italicize the additions
  buffer = buffer.replaceAllMapped(
      RegExp(r"\{\\ADD\{([\s\S]+?)\}\}"), (m) => text_italicize(m[1]!));

  return buffer;
}

/*
** chapters
*/

String parse_tex_chapters(String buffer) {
  // we're going to be a little bit sneaky here...
  //
  // show_chapter_title() and show_one_chap_title() will insert
  //   \ChapterHeader commands after the title
  //
  //   we process these out immediately afterwards

  // process chapter one's... -- should be title sized
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\ChapOne\{(\d+)\}"), (m) => text_chapter_title('CHAP.', m[1]!));

  // process Psalm chapters... -- should be title sized
  buffer = buffer.replaceAllMapped(RegExp(r"\\PsalmChap\{(\d+)\}"),
      (m) => text_chapter_title('PSAL.', m[1]!));

  // ...and the other chapters -- should be title sized
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\Chap\{(\d+)\}"), (m) => text_chapter_title('CHAP.', m[1]!));

  // do books with only one chapter
  buffer = buffer.replaceAllMapped('\\OneChap ', (m) => '\n\\ChapterHeader\n');

  // do chapter headers -- these are italic and smaller than regular text
  buffer =
      buffer.replaceAllMapped('\\ChapterHeader', (m) => text_chapter_header());

  return buffer;
}

/*
** titles
*/

// make list of book titles (long version of title)
String book_titles = read_file('$new_path/$titles_file');
List<String> book_list = book_titles.split('\n');

String parse_tex_titles(String buffer) {
  // show the short title for now...
  buffer = buffer.replaceAllMapped(
      RegExp(r"\\NormalFont\\ShortTitle\{([\s\S]+?)\}"),
      (m) => text_short_title(m[1]!));

  // show the long title -- should be title sized
  buffer = buffer.replaceAllMapped(RegExp(r"\{\\MT ([\s\S]+?)\\par \}"),
      (m) => '\n${text_large_title(book_list[current_book++])}');

  // another title -- Epistle of Jeremy -- should be title sized
  buffer = buffer.replaceAllMapped(RegExp(r"\{\\MS ([\s\S]+?)\\par \}"),
      (m) => '\n\n${text_large_title(m[1]!)}\n\n');

  // this one is used twice in the apocrypha for chapter subtitles
  // ignore them -- this information becomes part of the new main title
  buffer = buffer.replaceAll(RegExp(r"\{\\IS ([\s\S]+?)\\par \}"), '');

  // ignore these -- used in two places for 'commonly called'
  // this information becomes part of the new main title
  buffer =
      buffer.replaceAllMapped(RegExp(r"\{\\MTB ([\s\S]+?)\\par \}"), (m) => '');

  // some more titles -- tells what kind of Psalm that David wrote
  //                     also used for some other subheaders
  //                     should be text sized
  //   needs to come after small caps and italics
  buffer = buffer.replaceAllMapped(RegExp(r"\{\\D ([\s\S]+?)\\par \}"),
      (m) => "\n\n${text_title(m[1]!)}\n\n");

  // subheaders
  // psalm 119 and the Hebrew letters -- should be title sized
  const LRM = '\u200E'; // left right marker
  buffer = buffer.replaceAllMapped(
      RegExp(r"\{\\SH \{\\TL\{ ([\s\S]+?)\}\} \\par \}"),
      (m) => "\n\n${text_large_title('$LRM${m[1]}')}\n\n");

  // another version of \SH
  //   we get too many blank lines so we'll have to clean it up later
  buffer = buffer.replaceAllMapped(
      RegExp(r"\{\\SH ([\s\S]+?)\\par \}"), (m) => text_SH(m[1]!));

  return buffer;
}

/*
** other formatting -- need to happen after the font formatting
*/

String parse_tex_other(String buffer) {
  // ignore footnotes
  buffer = buffer.replaceAllMapped(
      RegExp(
          r"\\FTNT\{([^\}]+)\}\{\{\\FR \d+\.\d+ \}([\s\S\r]+?):([\s\S\r]+?)\}"),
      (m) => '||${m[0]}||');

  buffer = buffer.replaceAll(RegExp(r'\|\|.*\|\|'), '');

  // ignore words of Jesus formatting
  buffer = buffer.replaceAllMapped(
      RegExp(r"\{\\WJ\{([\s\S]+?)\}\}"), (m) => "${m[1]}");

  // remove residual \par } tokens -- Psalm verses have an extra at the end
  buffer = buffer.replaceAll(' \\par }', '');

  return buffer;
}

/*
**   clean things up a bit
*/

String parse_tex_cleanup(String buffer) {
  // remove trailing spaces
  buffer = buffer.replaceAll(' \n', '\n');
  buffer = buffer.replaceAll(' \n', '\n');
/*
  // remove leading spaces
  buffer = buffer.replaceAll('\n ', '\n');
  buffer = buffer.replaceAll('\n ', '\n');
*/
  // remove the extra blank lines
  buffer = buffer.replaceAll('\n\n\n', '\n\n');
  buffer = buffer.replaceAll('\n\n\n', '\n\n');
  buffer = buffer.replaceAll('\n\n\n', '\n\n');

  // remove the blank lines at the beginning of the file
  buffer = buffer.substring(2);

  // add a blank line to the end of the file
  buffer += '\n\n';

  return buffer;
}
