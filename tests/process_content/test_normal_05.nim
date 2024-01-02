import std/unicode

import ../../src/process_normal_numbers

proc cnt(text: string, pos: int): int =
    let c = count_start(text.toRunes(), pos)
    int(c)

assert cnt("12. ", 0) == 0
assert cnt("12. ", 1) == 0
assert cnt(" 12. ", 0) == 1
assert cnt(" 12. ", 1) == 0
assert cnt(" ", 2) == 0
assert cnt(" ", 0) == 1
