import std/unicode

import ../../src/process_roman_numbers

proc look(text: string, pos: int): bool =
    let (res, _) = look_ahead_number_point(text.toRunes(), pos)
    return res

assert look("I ", 0) == false
assert look(" II ", 0) == false
assert look(" VI ", 1) == false
assert look(" XI a", 0) == true
assert look(" II a", 1) == false
