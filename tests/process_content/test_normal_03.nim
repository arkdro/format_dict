import std/unicode

import ../../src/process_normal_numbers

proc cnt(text: string, pos: int): int =
    let c = count_finish(text.toRunes(), pos)
    int(c)

assert cnt("12. ", 0) == 0
assert cnt("12. ", 1) == 0
assert cnt(" 12. ", 0) == 0
assert cnt(" 12. ", 1) == 0
assert cnt(" 12. ", 2) == 0
assert cnt(" 12. ", 3) == 1
assert cnt(" 12. ", 4) == 0
