import std/unicode

import ../../src/process_normal_numbers

proc cnt(text: string, pos: int): int =
    let c = count_digits(text.toRunes(), pos)
    int(c)

assert cnt(" 12. ", 1) == 2
assert cnt("12. ", 1) == 1
assert cnt("12. ", 0) == 2
assert cnt(" 12. ", 2) == 1
assert cnt(" 12. ", 3) == 0
assert cnt(" 12. ", 4) == 0
