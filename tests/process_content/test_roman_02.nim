import std/unicode

import ../../src/process_roman_numbers

proc cnt(text: string, pos: int): int =
    let c = count_finish(text.toRunes(), pos)
    int(c)

assert cnt("XV. ", 0) == 0
assert cnt("VX. ", 1) == 0
assert cnt(" ", 0) == 1
assert cnt(" XI. ", 1) == 0
assert cnt(" VI. ", 2) == 0
assert cnt(" IV. ", 3) == 0
assert cnt(" IX. ", 4) == 1
assert cnt(" VV. ", 5) == 0
