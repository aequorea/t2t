# tex to text

# Revelation 18:22 has the missing words

# Lᴏʀᴅ is small caps -- JEHOVAH is all caps -- unless it's italics when 𝘓𝘰𝘳𝘥 is possible --
# or unless it's LORD in all caps -- so maybe lord is not consistent.
# Let's try to get this right.
# Does Gᴏᴅ exist (in small caps)? Looks like it.

# Exodus 33:9 There are no italic small caps in original 1769
# Convert LORD to italic uppercase
# Later versions like Oxford 1872 do have italic smallcaps
# but 1798 Cambridge doesn't - uppercase like 1769

# The first or second (and final) line of the Chapters 1, 3, 12, 19 summaries 
#   in Leviticus are centered.
# But evidently if the final line is line 3 or more it's left justified.
# II Samuel 22, the second line is not centered. Aargh!

# A typo -- Deu 9 header 'dissaudeth' (folio) -> 'dissuadeth' (quarto)

# ` ' ^ ° ˣ ⬝ 🞄 . -- things that are tiny and/or look like a superscript
# we'll probably mark up the text with backtick then change it to something else
# before training the OCR engine -- we pick one character to "trick" the engine

# █ ▓ ▒ ░ ▮ ┃ ┇ ⛇ ❚ 🁢 🖳 🗄 ⧗ -- for the weird character in Genesis 50

# … -- something that occurs in footnotes that we probably want to ignore

# 🞻 🞼 🞽 🞾 🞿 ✳ ❊ ❋ ✴ ✵ ✷ ✸ 🟎 🟏 🟐 🟑 -- for the special notes in Psalms 
# -- usually they are cross references (usually in chapter summaries which
#    can be found in Psalms and maybe some other places)

# daggers...
#  † ‡

# alpha_extended has no small caps 'x' because unicode doesn't have one

alpha_normal =    "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrsſtuvwxyz 0123456789:;,’"
alpha_extended =  "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrsſtuvwxyz ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀꜱᴛᴜᴠᴡʏᴢ 0123456789:;,’"
alpha_italics =   "𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍 𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠ʃ𝑡𝑢𝑣𝑤𝑥𝑦𝑧 𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑌𝑍 0123456789:;,’"
alpha_super =     "ᴬᴮꟲᴰᴱꟳᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾꟴᴿˢᵀᵁⱽᵂˣʸᶻ ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖ𐞥ʳˢᶴᵗᵘᵛʷˣʸᶻ ⁰¹²³⁴⁵⁶⁷⁸⁹:;,’"
actual_super=     "ᵃᵇᶜᵈᵉᶠᵍʰⁱᵏˡᵐⁿᵒᵖ𐞥ʳˢᵗᵘʷˣʸᶻ"
alpha_smallcaps = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀꜱſᴛᴜᴠᴡxʏᴢ 0123456789:;,’"
alpha_camelcaps = "ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ abcdefghijklmnopqrsſtuvwxyz 0123456789:;,’"
alpha_fullcaps =  "ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSſTUVWXYZ 0123456789:;,’"

# Sᴀᴍuel - Sᴀᴍᴜᴇʟ

italics = Dict(collect(alpha_extended) .=> collect(alpha_italics))
super = Dict(collect(alpha_normal) .=> collect(alpha_super))
smallcaps = Dict(collect(alpha_normal) .=> collect(alpha_smallcaps))
camelcaps = Dict(collect(alpha_normal) .=> collect(alpha_camelcaps))
fullcaps = Dict(collect(alpha_normal) .=> collect(alpha_fullcaps))

# Nice serif fonts are:
#   FreeSerif Regular
#   DejaVu Serif Book
#   EB Garamond - love the italic 'h' - very original looking - wide line spacing
#                 x-height a little short
#   Kelvinch Regular - superscripts fairly wonky - Planck's constant slightly off (italic 'h')
#                      but it does the 'ct' ligature - the only font so far that does

# OK serif fonts are:
#   Dehuti Book - superscripts a little wonky - Planck's constant a little off
#   Quivira Regular - overall letter spacing a little off


# set up closure to return a getcharwidth(char) function
mediancharwidth = 48 # yep, it's global all right

function init_getcharwidth()

    # These numbers come from: https://chrishewett.com/blog/calculating-text-width-programmatically/?
    #   where the font was eb garamond.
    # There was no difference between regular and italic as far as I could tell so we just
    #   will calculate based on the normal font.
    # That said, we'll need to stuff numbers for italics and small caps into the dict since
    #   we calculate and format after doing those kinds of substitutions
    # So this is fairly approximate, but maybe a little better than assuming a fixed-width font

    charwidths = Dict( ' ' => 20, '!' => 25, '\"' => 33, '$' => 44.1, '%' => 65, 
        '&' => 75.6, ''' => 20, '(' => 31.5, ')' => 31.5, '*' => 34, '+' => 59, 
        ',' => 23, '-' => 27.4, '.' => 23, '/' => 39.9, '0' => 48, '1' => 48, 
        '2' => 48, '3' => 48, '4' => 48, '5' => 48, '6' => 48, '7' => 48, 
        '8' => 48, '9' => 48, ':' => 24.8, ';' => 22.8, '<' => 56, '=' => 56.6, 
        '>' => 56, '?' => 37.6, '@' => 74.9, 'A' => 69.2, 'B' => 58.7, 'C' => 71, 
        'D' => 75.4, 'E' => 56.4, 'F' => 51.2, 'G' => 72.9, 'H' => 81, 'I' => 34, 
        'J' => 34, 'K' => 68.1, 'L' => 58.4, 'M' => 90.1, 'N' => 79.2, 'O' => 76.3, 
        'P' => 55.2, 'Q' => 76.3, 'R' => 71.3, 'S' => 46.5, 'T' => 67, 'U' => 73.8, 
        'V' => 67.2, 'W' => 91.6, 'X' => 70.7, 'Y' => 57.8, 'Z' => 60.3, '[' => 33.1, 
        '\\' => 39.9, ']' => 33.1, '^' => 50, '_' => 50, '`' => 20, 'a' => 39.9, 
        'b' => 51.5, 'c' => 40.7, 'd' => 50.6, 'e' => 39, 'f' => 31.8, 'g' => 43.5, 
        'h' => 51.5, 'i' => 24.5, 'j' => 22.6, 'k' => 46.9, 'l' => 24, 'm' => 77.8, 
        'n' => 52.8, 'o' => 49.5, 'p' => 51.9, 'q' => 52.2, 'r' => 33.4, 's' => 32.3, 
        't' => 31.4, 'u' => 52.7, 'v' => 43.8, 'w' => 68.5, 'x' => 43, 'y' => 43.8, 
        'z' => 37.7, '{' => 37.6, '|' => 26, '}' => 37.6, '~' => 50, '#' => 46.8)

    for ch in collect(alpha_normal)
        if haskey(charwidths, ch) width = charwidths[ch]
        else width = mediancharwidth
        end
        if !haskey(charwidths, italics[ch])
            charwidths[italics[ch]] = width
        end
        if !haskey(charwidths, smallcaps[ch])
            charwidths[smallcaps[ch]] = width
        end
    end
    
    # return an anonymous function -- pretend we know what we're doing
    function (char)
        if haskey(charwidths, char) return charwidths[char]
        else return(mediancharwidth)
        end
    end
end
getcharwidth = init_getcharwidth()
    
function getwordlength(word)
    wordlen = 0
    for ch in word
        wordlen += getcharwidth(ch)
    end
    return wordlen
end

# convert to roman numerals  
# from https://rosettacode.org/wiki/Roman_numerals/Encode
#
function romanencode(n::Integer)
    if n < 1 || n > 4999 throw(DomainError(n, "Roman numeral out of range.")) end

    DR = [["I", "X", "C", "M"] ["V", "L", "D", "MMM"]]
    rnum = ""
    for (omag, d) in enumerate(digits(n))
        if d == 0
            omr = ""
        elseif d <  4
            omr = DR[omag, 1] ^ d
        elseif d == 4
            omr = DR[omag, 1] * DR[omag, 2]
        elseif d == 5
            omr = DR[omag, 2]
        elseif d <  9
            omr = DR[omag, 2] * DR[omag, 1] ^ (d - 5)
        else
            omr = DR[omag, 1] * DR[omag + 1, 1]
        end
        rnum = omr * rnum
    end
    return rnum
end


pnum = 0


function loadfiles(buffer)
    re = r"\\input\{([\s\S]+?)\}"
    m = match(re, buffer)
    while m !== nothing
        fn = m.captures[1]*".tex"

        global pnum = 0
        println(fn)

        buffer = replace(buffer, re => read(fn, String); count=1)
        m = match(re, buffer)
    end
    return buffer
end

# split lines into bite sized pieces
# approximate the original 1769 folio
function makelines(para)
    linelen = 29 * mediancharwidth
    if getwordlength(para) < linelen return(para) end # preserve formatted text
    re = r"^\s*"
    # try not to eat leading spaces -- remember them
    m = match(re, para)
    curlen = getwordlength(m.match)
    newpara = m.match
    # divide the line into words
    words = split(para)
    # respect the desired line length
    for w in words
        if curlen + getwordlength(w) >= linelen
            curlen = 0
            newpara *= w * "\n"
        else
            curlen += getwordlength(w) + 1
            newpara *= w * " "
        end
    end
    # append a final newline if needed
    # if the final line is exactly the right length it isn't needed
    if curlen != 0
        newpara *= "\n"
    end
#    newpara = "   " * newpara
    return(newpara)
end

function formatbuffer(buffer)
    re = r"[\s\S]+?\n"
    newbuf = ""
    m = match(re, buffer)
    while m !== nothing
        para = m.match
        para = makelines(para)
        newbuf *= para
        buffer = replace(buffer, re => ""; count=1)
        m = match(re, buffer)
    end
#    newbuf = replace(newbuf, r"\n " => "\n")
    return newbuf
end

function formatitalics(buffer)
    # extract the paragraph
    re = r"\{\\ADD\{([\s\S]+?)\}\}"
    para = replace(buffer, re => s"\1")

    global pnum += 1
    println(pnum, para)

    if '{' in para
        println(para)
    end
    
    italic_text = ""
    for c in para
        italic_text *= italics[c]
    end
    # put the new paragraph back in the buffer (once)
    buffer = replace(buffer, re => italic_text; count = 1)
    return buffer
end

function formatsmallcaps(buffer)
    # extract the paragraph
    re = r"\{\\ND\{ ?([\s\S]+?)\}\}"
    para = replace(buffer, re => s"\1")
    para = lowercase(para)
    para = uppercasefirst(para)
    sc_text = ""
    for c in para
        sc_text *= smallcaps[c]
    end
    
    # put the new paragraph back in the buffer (once)
    buffer = replace(buffer, re => sc_text; count = 1)
    return buffer
end

function getfootnotemarkers(buffer)
    if count(":", buffer) == 2
        if findlast('.', buffer) > findlast(':', buffer)
            return(" ‖ †")
        else
            return(" † ‖")
        end
    elseif occursin(". ", buffer) return(" †")
    else return(" ‖")
    end
end

function processfootnotes(buffer)
    re = r"\\FTNT\{([^\}]+)\}\{\{\\FR \d+\.\d+ \}([\s\S\r]+?):([\s\S\r]+?)\}"
    m = match(re, buffer)
    dirty = m
    while m !== nothing
        tosub = strip(m[2], '…')
        marker = getfootnotemarkers(m.match)
        buffer = replace(buffer, tosub => marker * tosub)
        buffer = replace(buffer, re => ""; count=1)
        m = match(re, buffer)
    end
    return buffer
end

function processverseone(buffer)
    re = r"\\VerseOne\{(\d+)\}(\w+)"
    m = match(re, buffer)

    # this is a little bit tricky - not all first words are completely smallcaps
    # only smallcaps them if they were normal text at first - unfortunately the 
    # source text does not reflect this, so I Sam 15 will be in error
    # Should be Sᴀmuel but without special handling will turn out Sᴀᴍᴜᴇʟ
    # Need to correct source text to SAmuel for this to work

    firstword = ""
    letters = collect(m[2]) # word to smallcapsify
    if letters[2] in 'A':'Z'
        firstword = letters[1]
        for ch in letters[2:end]
            firstword *= camelcaps[ch]
        end
    else
        for ch in letters
            firstword *= smallcaps[ch]
        end
    end
    buffer = replace(buffer, m.match => firstword)
    return buffer
end

function processchapter(buffer)
    re = r"\\Chap\{(\d+)\}"
    m = match(re, buffer)
    chapter = "\n\n            C H A P.   " * romanencode(parse(Int64, m[1])) * "\n"
    buffer = replace(buffer, m.match => chapter)
    return buffer
end

function processchapterone(buffer)
    re = r"\\ChapOne\{(\d+)\}"
    m = match(re, buffer)
    chapter = "\n\n            C H A P.   " * romanencode(parse(Int64, m[1])) * "\n"
    buffer = replace(buffer, m.match => chapter)
    return buffer
end

#buffer = read("all.tex", String)
buffer = read("atest.tex", String)
#buffer = read("penta.tex", String)
buffer = loadfiles(buffer)

buffer = replace(buffer, r"\{\\PP ([\s\S]+?)\\par \}" => s"\1") # ignore paragraph markers
# turn the paragraphs into one long line ...
buffer = replace(buffer, r"\n" => " ")
# ... and remove double spaces
buffer = replace(buffer, "  " => " ")

buffer = replace(buffer, r"\\NormalFont\\ShortTitle\{([\s\S]+?)\}" => s"(\1)\n\n")
buffer = replace(buffer, r"\{\\MT ([\s\S]+?)\\par \}" => s"\1")
buffer = replace(buffer, r"\\ChapOne\{(\d+)\}" => processchapterone)
buffer = replace(buffer, r"\\Chap\{(\d+)\}" => processchapter)

buffer = replace(buffer, r"\\VerseOne\{(\d+)\}(\w+)" => processverseone)
buffer = replace(buffer, r" \\VS\{(\d+)\}" => s"\n  \1 ")

#println()
#print(buffer)
#println()

buffer = replace(buffer, r"\{\\WJ\{([\s\S]+?)\}\}" => s"\1")            # words of Jesus
buffer = replace(buffer, r"\{\\ND\{ ?([\s\S]+?)\}\}" => formatsmallcaps) # name of Deity
buffer = replace(buffer, r"\{\\ADD\{([\s\S]+?)\}\}" => formatitalics)   # additions

buffer = replace(buffer, r"[\s\S]+?\n" => processfootnotes)
buffer = formatbuffer(buffer)

println()
print(buffer)
println()

#i=1
#for (index, value) in pairs(charwidths)
#    println("$i - $index $value")
#    global i += 1
#end

# show_alphabets()