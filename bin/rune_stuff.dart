/*
** rune stuff
*/

/*
** make a list of chars from a string
*/

List<String> runeSplit(String str) {
  return [for (var rune in str.runes) String.fromCharCode(rune)];
}

/*
** get the length of a string in runes
*/

int runeLength(String str) {
  int len = str.runes.length;
//  if (str[str.length - 1] == '\n') len--;
  return len;
}
