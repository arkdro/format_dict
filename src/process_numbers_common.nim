import std/unicode

type Counter* = distinct int

proc has_some_chars*(chars: seq[Rune], cur_pos: int): bool =
    if chars.len == 0:
        return false
    let beyond_pos = chars.len
    cur_pos < beyond_pos
