

charwidths = Dict( ' ' => 20, '!' => 25, '\"' => 33, '#' => 46.8, '$' => 44.1, '%' => 65, '&' => 75.6, ''' => 20, '(' => 31.5, ')' => 31.5, '*' => 34, '+' => 59, ',' => 23, '-' => 27.4, '.' => 23, '/' => 39.9, '0' => 48, '1' => 48, '2' => 48, '3' => 48, '4' => 48, '5' => 48, '6' => 48, '7' => 48, '8' => 48, '9' => 48, ':' => 24.8, ';' => 22.8, '<' => 56, '=' => 56.6, '>' => 56, '?' => 37.6, '@' => 74.9, 'A' => 69.2, 'B' => 58.7, 'C' => 71, 'D' => 75.4, 'E' => 56.4, 'F' => 51.2, 'G' => 72.9, 'H' => 81, 'I' => 34, 'J' => 34, 'K' => 68.1, 'L' => 58.4, 'M' => 90.1, 'N' => 79.2, 'O' => 76.3, 'P' => 55.2, 'Q' => 76.3, 'R' => 71.3, 'S' => 46.5, 'T' => 67, 'U' => 73.8, 'V' => 67.2, 'W' => 91.6, 'X' => 70.7, 'Y' => 57.8, 'Z' => 60.3, '[' => 33.1, '\\' => 39.9, ']' => 33.1, '^' => 50, '_' => 50, '`' => 20, 'a' => 39.9, 'b' => 51.5, 'c' => 40.7, 'd' => 50.6, 'e' => 39, 'f' => 31.8, 'g' => 43.5, 'h' => 51.5, 'i' => 24.5, 'j' => 22.6, 'k' => 46.9, 'l' => 24, 'm' => 77.8, 'n' => 52.8, 'o' => 49.5, 'p' => 51.9, 'q' => 52.2, 'r' => 33.4, 's' => 32.3, 't' => 31.4, 'u' => 52.7, 'v' => 43.8, 'w' => 68.5, 'x' => 43, 'y' => 43.8, 'z' => 37.7, '{' => 37.6, '|' => 26, '}' => 37.6, '~' => 50)

i=1
for (index, value) in pairs(charwidths)
    println("$i - $index $value")
    global i += 1
end
