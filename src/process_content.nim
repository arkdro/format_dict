import std/unicode

import process_normal_numbers
import process_roman_numbers

proc add_original_char(data: var seq[Rune], char: Rune) =
    data.add(char)

proc add_look_ahead_chars(data: var seq[Rune], chars: seq[Rune], idx: int, num_of_chars: int) =
    for i in idx ..< idx + num_of_chars:
        let char = chars[i]
        data.add(char)

proc iterate_chars(chars: seq[Rune]): seq[Rune] =
    var res: seq[Rune] = @[]
    var idx = 0
    while idx < chars.len:
        let (matched, num_of_chars) = process_normal_numbers.look_ahead_number_point(chars, idx)
        if matched:
            process_normal_numbers.add_header(res)
            add_look_ahead_chars(res, chars, idx, num_of_chars)
            process_normal_numbers.add_footer(res)
            idx += num_of_chars
        else:
            let (matched, num_of_chars) = process_roman_numbers.look_ahead_number_point(chars, idx)
            if matched:
                process_roman_numbers.add_header(res)
                add_look_ahead_chars(res, chars, idx, num_of_chars)
                process_roman_numbers.add_footer(res)
                idx += num_of_chars
            else:
                let char = chars[idx]
                add_original_char(res, char)
                idx += 1
    return res

proc process_content*(content: string): string =
    var chars = toRunes(content)
    let new_chars = iterate_chars(chars)
    let new_content = $(new_chars)
    return new_content
