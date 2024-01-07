import std/unicode

import ../../src/process_content

proc iter(input: string): string =
    let r = iterate_chars(input.toRunes())
    $(r)

assert iter("из ab") == "из \nab"
assert iter("<db>из</db>") == "<db>из</db>"
assert iter("го&apos;род") == "го&apos;род"
