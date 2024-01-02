import std/unicode

import ../../src/process_roman_numbers

proc get_chars(data: string): seq[Rune] =
    var chars = toRunes(data)
    return chars


proc is_digit(data: string, pos: int): bool =
    var chars = get_chars(data)
    return is_digit_at_pos(chars, pos)

assert is_digit("asdf", 0) == false
assert is_digit("1", 0) == false
assert is_digit("i", 0) == false
assert is_digit("I", 0) == true
assert is_digit("V", 0) == true
assert is_digit("X", 0) == true
assert is_digit("X1", 1) == false
