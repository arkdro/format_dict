import std/unicode

import ../../src/process_content

proc iter(input: string): string =
    let r = iterate_chars(input.toRunes())
    $(r)

assert iter("asdf") == "asdf"
assert iter(" I ") == " \n\n<h4>I</h4> "
assert iter(" VI ") == " \n\n<h4>VI</h4> "
assert iter(" VI 1. a") == " \n\n<h4>VI</h4> \n\n<b>1.</b> a"
assert iter(" 1. aaa 2.: bbb bb") == " \n\n<b>1.</b> aaa \n\n<b>2.:</b> bbb bb"
