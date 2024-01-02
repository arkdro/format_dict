import args
import process_file

when isMainModule:
  var (infile, outfile) = get_tokens()
  process_file(infile, outfile)
  echo("Done.")
