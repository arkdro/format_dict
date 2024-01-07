import std/unicode

import process_html_entities
import process_normal_numbers
import process_roman_numbers

const text_break = "\n".toRunes
const less_sign = "<".toRunes[0]
const slash = "/".toRunes[0]

const latin_text_utf8_ranges = @[(0x41, 0x5a), (0x61, 0x7a), (0xc280, 0xc2bf), (0xc380, 0xc3bf)]
const cyrillic_ranges = @[(0x400, 0x4ff)]

type Language = enum
    Punctuation,
    EN,
    DE,
    RU

var current_language = Punctuation
var closing_xml_tag = false

proc add_original_char(data: var seq[Rune], char: Rune) =
    data.add(char)

proc add_look_ahead_chars(data: var seq[Rune], chars: seq[Rune], idx: int, num_of_chars: int) =
    for i in idx ..< idx + num_of_chars:
        let char = chars[i]
        data.add(char)

proc insert_break(data: var seq[Rune]) =
    data.add(text_break)

proc in_ranges(ranges: seq[(int, int)], char: Rune): bool =
    let code = int(char)
    for (start, stop) in ranges:
        if start <= code and code <= stop:
            return true
    return false

proc is_en(char: Rune): bool =
    in_ranges(latin_text_utf8_ranges, char)

proc is_ru(char: Rune): bool =
    in_ranges(cyrillic_ranges, char)

proc is_de(char: Rune): bool =
    is_en(char)

proc language_changed_from_ru_to_de(char: Rune): bool =
    current_language == RU and is_de(char)

proc set_current_language_flag(char: Rune) =
    if is_ru(char):
        current_language = RU
    elif is_de(char):
        current_language = DE

proc set_de_language_flag() =
    current_language = DE

proc is_less_sign(char: Rune): bool =
    char == less_sign

proc start_closing_xml_tag() =
    closing_xml_tag = true

proc remove_closing_xml_tag() =
    closing_xml_tag = false

proc continue_closing_xml_tag(char: Rune): bool =
    closing_xml_tag == true and char == slash

proc iterate_chars*(chars: seq[Rune]): seq[Rune] =
    var res: seq[Rune] = @[]
    var idx = 0
    while idx < chars.len:
        let char = chars[idx]
        let original_char_length = 1
        if is_less_sign(char):
            start_closing_xml_tag()
        else:
            if continue_closing_xml_tag(char):
                set_de_language_flag()
            else:
                remove_closing_xml_tag()
        if language_changed_from_ru_to_de(char):
            set_current_language_flag(char)
            insert_break(res)
            add_original_char(res, char)
            idx += original_char_length
            continue
        set_current_language_flag(char)
        add_original_char(res, char)

        let (matched_html, num_of_html_chars) = process_html_entities.look_ahead(chars, idx)
        if matched_html:
            add_look_ahead_chars(res, chars, idx + original_char_length, num_of_html_chars)
            idx += num_of_html_chars
        else:
            let (matched, num_of_chars) = process_normal_numbers.look_ahead_number_point(chars, idx)
            if matched:
                set_de_language_flag()
                process_normal_numbers.add_header(res)
                add_look_ahead_chars(res, chars, idx + original_char_length, num_of_chars)
                process_normal_numbers.add_footer(res)
                idx += num_of_chars
            else:
                let (matched, num_of_chars) = process_roman_numbers.look_ahead_number_point(chars, idx)
                if matched:
                    set_de_language_flag()
                    process_roman_numbers.add_header(res)
                    add_look_ahead_chars(res, chars, idx + original_char_length, num_of_chars)
                    process_roman_numbers.add_footer(res)
                    idx += num_of_chars
        idx += original_char_length
    return res

proc process_content*(content: string): string =
    var chars = toRunes(content)
    let new_chars = iterate_chars(chars)
    let new_content = $(new_chars)
    return new_content
