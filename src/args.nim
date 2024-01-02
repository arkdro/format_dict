import std/parseopt

const infile_short_tag = "i"
const infile_long_tag = "infile"
const outfile_short_tag = "o"
const outfile_long_tag = "outfile"

const default_infile = "f.in"
const default_outfile = "f.out"

proc get_tokens*(): (string, string) =
    var parser = initOptParser("")
    var infile = default_infile
    var outfile = default_outfile
    for kind, key, val in parser.getopt():
        case kind
            of cmdEnd:
                break
            of cmdShortOption, cmdLongOption:
                if key == infile_short_tag or key == infile_long_tag:
                    infile = val
                if key == outfile_short_tag or key == outfile_long_tag:
                    outfile = val
            of cmdArgument:
                continue
    (infile, outfile)
