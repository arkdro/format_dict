proc get_content*(file_name: string): string =
    var data = readFile(file_name)
    return data
