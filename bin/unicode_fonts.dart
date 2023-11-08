// prevent Dart linter from complaining about snake_case:
//   ignore_for_file: constant_identifier_names
//   ignore_for_file: non_constant_identifier_names

/*
** unicode 'fonts'
**
** Nice serif fonts are:
**   FreeSerif Regular
**   DejaVu Serif Book
**   EB Garamond - love the italic 'h' - very original looking - wide line 
**     spacing - x-height a little short
**   Kelvinch Regular - superscripts fairly wonky - Planck's constant slightly 
**     off (italic 'h') but it does the 'ct' ligature - the only font so far 
**     that does
**
** OK serif fonts are:
**   Dehuti Book - superscripts a little wonky - Planck's constant a little off
**   Quivira Regular - overall letter spacing a little off
*/

import 'rune_stuff.dart';

/*
** set up the character style maps -- the unicode 'fonts'
*/

// italic long S
const iLongS = '\u0283'; // esh ʃ
// const iLongS = '\u222b'; // integral sign ∫

const alpha_smallcaps =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀꜱᴛᴜᴠᴡxʏᴢſ 0123456789:;,’^~.";
const alpha_fraktur =
    "𝕬𝕭𝕮𝕯𝕰𝕱𝕲𝕳𝕴𝕵𝕶𝕷𝕸𝕹𝕺𝕻𝕼𝕽𝕾𝕿𝖀𝖁𝖂𝖃𝖄𝖅 𝖆𝖇𝖈𝖉𝖊𝖋𝖌𝖍𝖎𝖏𝖐𝖑𝖒𝖓𝖔𝖕𝖖𝖗𝖘𝖙𝖚𝖛𝖜𝖝𝖞𝖟ſ 0123456789:;,’^~.";
const alpha_normal =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzſ 0123456789:;,’^~.";
const alpha_italics =
    "𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍 𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠𝑡𝑢𝑣𝑤𝑥𝑦𝑧$iLongS 0123456789:;,’^~.";
const alpha_extended =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzſ ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀꜱᴛᴜᴠᴡʏᴢ 0123456789:;,’-?'!-.[]\n()&Æ^~";
const alpha_italics_extended =
    "𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍 𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠𝑡𝑢𝑣𝑤𝑥𝑦𝑧$iLongS 𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑌𝑍 0123456789:;,’-?’!-.[]\n()&Æ^~";

const alpha_normal_short =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz�ſ";
const alpha_italics_short =
    "𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠𝑡𝑢𝑣𝑤𝑥𝑦𝑧@$iLongS";
/*
** turn our 'fonts' into lists
*/

List<String> alpha_smallcaps_chars = runeSplit(alpha_smallcaps);
List<String> alpha_fraktur_chars = runeSplit(alpha_fraktur);
List<String> alpha_normal_chars = runeSplit(alpha_normal);
List<String> alpha_italics_chars = runeSplit(alpha_italics);
List<String> alpha_extended_chars = runeSplit(alpha_extended);
List<String> alpha_italics_extended_chars = runeSplit(alpha_italics_extended);

List<String> alpha_normal_short_chars = runeSplit(alpha_normal_short);
List<String> alpha_italics_short_chars = runeSplit(alpha_italics_short);

/*
** turn the lists into maps
*/

Map<String, String> smallcaps =
    Map.fromIterables(alpha_normal_chars, alpha_smallcaps_chars);
Map<String, String> fraktur =
    Map.fromIterables(alpha_normal_chars, alpha_fraktur_chars);
Map<String, String> italics =
    Map.fromIterables(alpha_extended_chars, alpha_italics_extended_chars);

/*
** some things to save for later -- just in case
*/

/*
const alpha_superscript =
    "ᴬᴮꟲᴰᴱꟳᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾꟴᴿˢᵀᵁⱽᵂˣʸᶻ ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖ𐞥ʳˢᶴᵗᵘᵛʷˣʸᶻ ⁰¹²³⁴⁵⁶⁷⁸⁹:;,’";
const actual_superscript = "ᵃᵇᶜᵈᵉᶠᵍʰⁱᵏˡᵐⁿᵒᵖ𐞥ʳˢᵗᵘʷˣʸᶻ";
const alpha_camelcaps =
    "ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ abcdefghijklmnopqrsſtuvwxyz 0123456789:;,’";
const alpha_fullcaps =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSſTUVWXYZ 0123456789:;,’";
*/

/*
List<String> alpha_superscript_chars = runeSplit(alpha_superscript);
List<String> alpha_camelcaps_chars = runeSplit(alpha_camelcaps);
List<String> alpha_fullcaps_chars = runeSplit(alpha_fullcaps);
*/

/*
Map<String, String> superscript =
    Map.fromIterables(alpha_normal_chars, alpha_superscript_chars);
Map<String, String> camelcaps =
    Map.fromIterables(alpha_normal_chars, alpha_camelcaps_chars);
Map<String, String> fullcaps =
    Map.fromIterables(alpha_normal_chars, alpha_fullcaps_chars);
*/

/*
** variable font width stuff -- might not use...
*/

/*
** Table of char widths.
**
** These numbers come from: 
**   https://chrishewett.com/blog/calculating-text-width-programmatically/?
**   where the font was eb garamond.
** There was no difference between regular and italic as far as I could tell 
**   so we will just calculate based on the normal font.
** That said, we'll need to stuff numbers for italics and small caps into the 
**   dict since we calculate and format after doing those kinds of 
**   substitutions.
** For better or worse, we use the width of the lower case letters for the 
**   small caps.
** So this is fairly approximate, but maybe a little better than assuming a 
**   fixed-width font
*/

const mediancharwidth = 48.0;

Map<String, double> charwidths = {
  ' ': 20,
  '!': 25,
  '"': 33,
  '\$': 44.1,
  '%': 65,
  '&': 75.6,
  '\'': 20,
  '(': 31.5,
  ')': 31.5,
  '*': 34,
  '+': 59,
  ',': 23,
  '-': 27.4,
  '.': 23,
  '/': 39.9,
  '0': 48,
  '1': 48,
  '2': 48,
  '3': 48,
  '4': 48,
  '5': 48,
  '6': 48,
  '7': 48,
  '8': 48,
  '9': 48,
  ':': 24.8,
  ';': 22.8,
  '<': 56,
  '=': 56.6,
  '>': 56,
  '?': 37.6,
  '@': 74.9,
  'A': 69.2,
  'B': 58.7,
  'C': 71,
  'D': 75.4,
  'E': 56.4,
  'F': 51.2,
  'G': 72.9,
  'H': 81,
  'I': 34,
  'J': 34,
  'K': 68.1,
  'L': 58.4,
  'M': 90.1,
  'N': 79.2,
  'O': 76.3,
  'P': 55.2,
  'Q': 76.3,
  'R': 71.3,
  'S': 46.5,
  'T': 67,
  'U': 73.8,
  'V': 67.2,
  'W': 91.6,
  'X': 70.7,
  'Y': 57.8,
  'Z': 60.3,
  '[': 33.1,
  '\\': 39.9,
  ']': 33.1,
  '^': 50,
  '_': 50,
  '`': 20,
  'a': 39.9,
  'b': 51.5,
  'c': 40.7,
  'd': 50.6,
  'e': 39,
  'f': 31.8,
  'g': 43.5,
  'h': 51.5,
  'i': 24.5,
  'j': 22.6,
  'k': 46.9,
  'l': 24,
  'm': 77.8,
  'n': 52.8,
  'o': 49.5,
  'p': 51.9,
  'q': 52.2,
  'r': 33.4,
  's': 32.3,
  't': 31.4,
  'u': 52.7,
  'v': 43.8,
  'w': 68.5,
  'x': 43,
  'y': 43.8,
  'z': 37.7,
  '{': 37.6,
  '|': 26,
  '}': 37.6,
  '~': 50,
  '#': 46.8
};

/*
** set up character widths for italics and small caps -- just fakin' it
*/

void init_charwidths() {
  for (var ch in alpha_normal_chars) {
    charwidths[italics[ch]!] =
        charwidths.containsKey(ch) ? charwidths[ch]! : mediancharwidth;
    charwidths[smallcaps[ch]!] =
        charwidths.containsKey(ch) ? charwidths[ch]! : mediancharwidth;
  }
}

/*
** get the width of a character
*/

double getcharwidth(String ch) {
  return charwidths.containsKey(ch) ? charwidths[ch]! : mediancharwidth;
}

/*
** get the width of a word
*/

double getwordlength(String str) {
  double wordlength = 0;
  List<String> chars = runeSplit(str);

  for (String ch in chars) {
    wordlength += getcharwidth(ch);
  }

  return wordlength;
}
