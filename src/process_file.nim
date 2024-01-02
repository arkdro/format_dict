import process_content
import read_file
import write_file

proc process_file*(input_file: string, output_file: string) =
  var content = get_content(input_file)
  var new_content = process_content(content)
  write(output_file, new_content)

