import std/unicode

from process_numbers_common import Counter, has_some_chars

const space = " ".toRunes[0]

# only smallest numbers are checked 
# FIXME: handle all roman numbers
const digits = @[
    "I".toRunes[0],
    "V".toRunes[0],
    "X".toRunes[0]
]

const header = "\n\n<h4>".toRunes
const footer = "</h4>".toRunes

const min_number_of_start_chars = 1
const min_number_of_digits = 1
const finish_length = 1

proc is_digit_at_pos*(chars: seq[Rune], pos: int): bool =
    let char = chars[pos]
    digits.contains(char)

proc count_digits*(chars: seq[Rune], pos: int): Counter =
    var cur_pos = pos
    var counter = 0
    while(true):
        if has_some_chars(chars, cur_pos):
            if is_digit_at_pos(chars, cur_pos):
                counter += 1
                cur_pos += 1
            else:
                return Counter(counter)
        else:
            return Counter(counter)

proc count_start*(chars: seq[Rune], pos: int): Counter =
    if pos >= chars.len:
        return Counter(0)
    if chars[pos] == space:
        return Counter(1)
    return Counter(0)

proc count_finish*(chars: seq[Rune], pos: int): Counter =
    if has_some_chars(chars, pos):
        if chars[pos] == space:
            return Counter(1)
    return Counter(0)

proc look_ahead_number_point*(chars: seq[Rune], pos: int): (bool, int) =
    if not has_some_chars(chars, pos):
        return (false, 0)
    let num_of_start_chars = count_start(chars, pos)
    if int(num_of_start_chars) < min_number_of_start_chars:
        return (false, 0)
    let pos_after_start = pos + int(num_of_start_chars)
    let num_of_digits = count_digits(chars, pos_after_start)
    if int(num_of_digits) < min_number_of_digits:
        return (false, 0)
    let pos_after_digits = pos_after_start + int(num_of_digits)
    if has_some_chars(chars, pos_after_digits):
        let num_of_finish_chars = count_finish(chars, pos_after_digits)
        if int(num_of_finish_chars) < finish_length:
            return (false, 0)
        let n = int(num_of_digits)
        return (true, n)
    else:
        return (false, 0)

proc add_header*(data: var seq[Rune]) =
    data.add(header)

proc add_footer*(data: var seq[Rune]) =
    data.add(footer)
