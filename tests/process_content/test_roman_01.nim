import std/unicode

import ../../src/process_roman_numbers

proc cnt(text: string, pos: int): int =
    let c = count_digits(text.toRunes(), pos)
    int(c)

assert cnt(" 12. ", 1) == 0
assert cnt(" I. ", 1) == 1
assert cnt("II ", 0) == 2
assert cnt(" VI. ", 2) == 1
assert cnt(" IX. ", 1) == 2
assert cnt(" iX. ", 1) == 0
assert cnt(" ViX. ", 1) == 1
assert cnt(" VI12. ", 0) == 0
assert cnt(" VI12. ", 1) == 2
assert cnt(" VI12. ", 3) == 0
