import std/unicode

import ../../src/process_normal_numbers

proc look(text: string, pos: int): bool =
    let (res, _) = look_ahead_number_point(text.toRunes(), pos)
    return res

assert look("12. ", 0) == false
assert look(" 12. ", 0) == true
assert look(" 12. ", 1) == false
assert look(" 12. a", 0) == true
assert look(" 12. a", 1) == false
