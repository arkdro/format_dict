import std/unicode

from process_numbers_common import Counter, has_some_chars

const semi_colon = ";".toRunes[0]
const ampersand = "&".toRunes[0]

const min_number_of_start_chars = 1
const min_number_of_digits = 1
const finish_length = 1

proc is_text_char_at_pos(chars: seq[Rune], pos: int): bool =
    isAlpha(chars[pos])

proc count_entity_chars*(chars: seq[Rune], pos: int): Counter =
    var cur_pos = pos
    var counter = 0
    while(true):
        if has_some_chars(chars, cur_pos):
            if is_text_char_at_pos(chars, cur_pos):
                counter += 1
                cur_pos += 1
            else:
                return Counter(counter)
        else:
            return Counter(counter)

proc count_start*(chars: seq[Rune], pos: int): Counter =
    if has_some_chars(chars, pos):
        if chars[pos] == ampersand:
            return Counter(1)
    return Counter(0)

proc count_finish*(chars: seq[Rune], pos: int): Counter =
    if not has_some_chars(chars, pos + 1):
        return Counter(0)
    if chars[pos] == semi_colon:
        return Counter(1)
    return Counter(0)

proc look_ahead*(chars: seq[Rune], pos: int): (bool, int) =
    if not has_some_chars(chars, pos):
        return (false, 0)
    let num_of_chars_start = count_start(chars, pos)
    if int(num_of_chars_start) < min_number_of_start_chars:
        return (false, 0)
    let pos_after_start = pos + int(num_of_chars_start)
    let num_of_digits = count_entity_chars(chars, pos_after_start)
    if int(num_of_digits) < min_number_of_digits:
        return (false, 0)
    let pos_after_digits = pos_after_start + int(num_of_digits)
    if has_some_chars(chars, pos_after_digits):
        let num_of_chars_finish = count_finish(chars, pos_after_digits)
        if int(num_of_chars_finish) < finish_length:
            return (false, 0)
        let n = int(num_of_digits) + int(num_of_chars_finish)
        return (true, n)
    else:
        return (false, 0)
