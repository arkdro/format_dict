# `format_dict`

Some dictionaries contain almost no formatting, just a stream of text.

`format_dict` adds some formatting to the dictionary.

It takes an input file of a stardict xml dictionary and
adds some formatting for numbered items:

- roman numbered: add `h4` html tag around the numbers
- arabic numbered: add `b` html tag around the numbers

## Example

input:

```
a b I c 1. ddd 2. ttt d 3.: ccc XV 1. eee 2. fff
```

output:

```
a b 

<h4>I</h4> c 

<b>1.</b> ddd 

<b>2.</b> ttt d 

<b>3.:</b> ccc 

<h4>XV</h4> 

<b>1.</b> eee 

<b>2.</b> fff
```

## Usage

```
format_dict --infile=INPUT_FILE --outfile=OUTPUT_FILE
```

## License

GNU General Public License version 3
