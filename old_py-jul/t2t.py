#!/bin/python3

# t2t.py -- tex to text (2021-09-25)
#           convert ebible.org .tex file into a text file


import sys
import re

def read_input_file(match_obj):
    if match_obj.group(1) is not None:
        filename = match_obj.group(1) + ".tex"
        with open(filename) as f:
            file = f.read()
            return input_file

def format_paragraph(match_obj):
    if match_obj.group(1) is not None:
        para = re.sub(r"\n", " ", match_obj.group(1))
        para = re.sub("  ", " ", para)
        para = para + "\n\n"
        para = re.sub(r" \n", r"\n", para)
        return para
        
input_file = sys.argv[1]

with open(input_file) as f:
    buffer = f.read()
    buffer = re.sub(r"\\input\{([\s\S]+?)\}", read_input_file, buffer)
    buffer = re.sub(r"\\NormalFont\\ShortTitle\{([\s\S]+?)\}", r"\1\n", buffer)
    buffer = re.sub(r"\{\\MTB ([\s\S]+?)\\par \}", "", buffer)
    buffer = re.sub(r"\{\\MTC ([\s\S]+?)\\par \}", "", buffer)
    buffer = re.sub(r"\{\\MT ([\s\S]+?)\\par \}", "", buffer)
    buffer = re.sub(r"\\ChapOne\{(\d+)\}", r"Chapter \1\n", buffer)
    buffer = re.sub(r"\\Chap\{(\d+)\}", r"Chapter \1\n", buffer)
    buffer = re.sub(r"\\VerseOne\{(\d+)\}", "", buffer)
    buffer = re.sub(r"\\VS\{(\d+)\}", "", buffer)
    buffer = re.sub(r"\\FTNT\{[^\}]+\}\{\{\\FR \d+:\d+: \}([^\}]+)\}", "", buffer)
    buffer = re.sub(r"\\XREF\{[^\}]+\}\{\{\\XO \d+:\d+: \}([^\}]+)\}", "", buffer)
    buffer = re.sub(r"\{\\WJ\{([\s\S]+?)\}\}", r"\1", buffer)
    buffer = re.sub(r"\{\\PP ([\s\S]+?)\\par \}", format_paragraph, buffer)
    buffer = re.sub(r"\{\\QB ([\s\S]+?)\\par \}", r"\1\n", buffer)
    buffer = re.sub(r"\{\\Q ([\s\S]+?)\\par \}", r"\1\n", buffer)
    buffer = re.sub(r"\{\\BB ([\s\S]+?)\\par \}", r"\1\n", buffer)
    print(buffer, "", end="")

