import std/unicode

import ../../src/process_numbers_common

assert has_some_chars("asdf".toRunes(), 0) == true
assert has_some_chars("asdf".toRunes(), 3) == true
assert has_some_chars("asdf".toRunes(), 4) == false
assert has_some_chars("asdf".toRunes(), 5) == false

assert has_some_chars("".toRunes(), 0) == false
assert has_some_chars("".toRunes(), -1) == false
