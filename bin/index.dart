// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names
//   ignore_for_file: prefer_interpolation_to_compose_strings

const int maxInteger = 0x7FFFFFFFFFFFFFFF;

/*
** Bible book abbreviations
*/

final abbr = {
  'Genesis': 'gen',
  'Exodus': 'exo',
  'Leviticus': 'lev',
  'Numbers': 'num',
  'Deuteronomy': 'deu',
  'Joshua': 'jos',
  'Judges': 'judg',
  'Ruth': 'rut',
  '1 Samuel': '1sa',
  '2 Samuel': '2sa',
  '1 Kings': '1ki',
  '2 Kings': '2ki',
  '1 Chronicles': '1ch',
  '2 Chronicles': '2ch',
  'Ezra': 'ezr',
  'Nehemiah': 'neh',
  'Esther': 'est',
  'Job': 'job',
  'Psalms': 'psa',
  'Proverbs': 'pro',
  'Ecclesiastes': 'ecc',
  'Song of Solomon': 'sos',
  'Isaiah': 'isa',
  'Jeremiah': 'jer',
  'Lamentations': 'lam',
  'Ezekiel': 'eze',
  'Daniel': 'dan',
  'Hosea': 'hos',
  'Joel': 'joe',
  'Amos': 'amo',
  'Obadiah': 'oba',
  'Jonah': 'jon',
  'Micah': 'mic',
  'Nahum': 'nah',
  'Habakkuk': 'hab',
  'Zephaniah': 'zep',
  'Haggai': 'hag',
  'Zechariah': 'zec',
  'Malachi': 'mal',
  '1 Esdras': '1es',
  '2 Esdras': '2es',
  'Tobit': 'tob',
  'Judith': 'judi',
  'Esther (Greek)': 'res', // the rest of esther
  'Wisdom': 'wis',
  'Sirach': 'ecu', // ecclesiasticus
  'Baruch': 'bar',
  'Azariah': 'so3', // the song of 3 children
  'Susanna': 'sus',
  'Bel': 'bel',
  'Manasseh': 'man',
  '1 Maccabees': '1ma',
  '2 Maccabees': '2ma',
  'Matthew': 'mat',
  'Mark': 'mar',
  'Luke': 'luk',
  'John': 'joh',
  'Acts': 'act',
  'Romans': 'rom',
  '1 Corinthians': '1co',
  '2 Corinthians': '2co',
  'Galatians': 'gal',
  'Ephesians': 'eph',
  'Philippians': 'php',
  'Colossians': 'col',
  '1 Thessalonians': '1th',
  '2 Thessalonians': '2th',
  '1 Timothy': '1ti',
  '2 Timothy': '2ti',
  'Titus': 'tit',
  'Philemon': 'phl',
  'Hebrews': 'heb',
  'James': 'jam',
  '1 Peter': '1pe',
  '2 Peter': '2pe',
  '1 John': '1jo',
  '2 John': '2jo',
  '3 John': '3jo',
  'Jude': 'jude',
  'Revelation': 'rev',
};

print_abbrev() {
  List<String> al = [];
  String ch;
  for (ch in abbr.keys) {
    al.add(abbr[ch]!);
  }
  al.sort();
  for (ch in al) {
    print(ch);
  }
}

/*
** get next token -- a little brute force
*/

const NO_TOKEN = 0;
const BOOK_TOKEN = 1;
const CHAP_TOKEN = 2;
const CHAP1_TOKEN = 3;
const PSALM_TOKEN = 4;
const PSALM1_TOKEN = 5;

int ibk = 0;
int ich = 0;
int ich1 = 0;
int ci = 0;
int ips = 0;
int ips1 = 0;

int get_next_token(String buf) {
  ibk = buf.indexOf(r'\ShortTitle{', ci);
  ich = buf.indexOf(r'\Chap{', ci);
  ich1 = buf.indexOf(r'\ChapOne{', ci);
  ips = buf.indexOf(r'\PsalmChap{', ci);
  ips1 = buf.indexOf(r'\PsalmChap1{', ci);

  if (ibk < 0) ibk = maxInteger - 1;
  if (ich < 0) ich = maxInteger - 1;
  if (ich1 < 0) ich1 = maxInteger - 1;
  if (ips < 0) ips = maxInteger - 1;
  if (ips1 < 0) ips1 = maxInteger - 1;

  if (is_min(ibk, ich, ich1, ips, ips1)) return BOOK_TOKEN;
  if (is_min(ich, ibk, ich1, ips, ips1)) return CHAP_TOKEN;
  if (is_min(ich1, ibk, ich, ips, ips1)) return CHAP1_TOKEN;
  if (is_min(ips, ibk, ich, ich1, ips1)) return PSALM_TOKEN;
  if (is_min(ips1, ibk, ich, ich1, ips)) return PSALM1_TOKEN;

  return NO_TOKEN;
}

bool is_min(int v1, int v2, int v3, int v4, int v5) {
  return (v1 < v2 && v1 < v3 && v1 < v4 && v1 < v5);
}

String latest_book = '';
String latest_chap = '';

String gen_index(String buf) {
  ci = 0;
  while (true) {
    int token = get_next_token(buf);
    switch (token) {
      case NO_TOKEN:
        return buf;
      case BOOK_TOKEN:
        buf = buf.replaceFirstMapped(RegExp(r'\\ShortTitle\{(.+?)\}'),
            (m) => index_book(m[0]!, m[1]!), ci);
        ci = ibk + 1;
        break;
      case CHAP_TOKEN:
        buf = buf.replaceFirstMapped(
            RegExp(r'\\Chap\{(.+?)\}'), (m) => index_chap(m[0]!, m[1]!), ci);
        ci = ich + 1;
        break;
      case CHAP1_TOKEN:
        buf = buf.replaceFirstMapped(
            RegExp(r'\\ChapOne\{(.+?)\}'), (m) => index_chap(m[0]!, m[1]!), ci);
        ci = ich1 + 1;
        break;
      case PSALM_TOKEN:
        buf = buf.replaceFirstMapped(RegExp(r'\\PsalmChap\{(.+?)\}'),
            (m) => index_chap(m[0]!, m[1]!), ci);
        ci = ips + 1;
        break;
      case PSALM1_TOKEN:
        buf = buf.replaceFirstMapped(RegExp(r'\\PsalmChapOne\{(.+?)\}'),
            (m) => index_chap(m[0]!, m[1]!), ci);
        ci = ips1 + 1;
        break;
    }
  }
}

String index_book(String mat, String str) {
  latest_book = str;
  String index = make_book_entry(str);
  return '$mat$index';
}

String index_chap(String mat, String str) {
  latest_chap = str;
  String index = make_chap_entry(latest_book, latest_chap);
  return '$mat$index';
}

String make_book_entry(String book) {
  String ab = abbr[book]!;
  book = book.replaceAll(' ', '');
  book = book.replaceAll('(', '');
  book = book.replaceAll(')', '');
  book = book.toLowerCase();
  ab = explode_abbr(ab, '');
  book = explode_abbr(book, '');
  return '[$ab /.b ]';
//  return '[$ab /.b ]';
}

String make_chap_entry(String book, String chap) {
  String ab = abbr[book]!;
  book = book.replaceAll(' ', '');
  book = book.replaceAll('(', '');
  book = book.replaceAll(')', '');
  book = book.toLowerCase();
  ab = explode_abbr(ab, chap);
  book = explode_abbr(book, chap);
  return '[$ab /.c ]\n';
//  return '[/$ab /.c ]\n';
}

String explode_abbr(String abbr, String chap) {
  List<String> frags = ['/'];
  List<String> chars = abbr.split('');
  int idx = 1;
  for (String ch in chars) {
    frags.add(frags[idx++ - 1] + ch);
  }

  String fragstring = '';
  for (String frag in frags.sublist(1)) {
    fragstring += '$frag $chap ';
  }
  return fragstring;
}
