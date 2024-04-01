package ini

import "core:fmt"
import "core:os"

read_from_string :: proc(content: string, name := "config.ini") -> ^Config {
    config := new_config(name)
    l := new_lexer(content)
    tokens := lex(l)
    p := new_parser(tokens, config)
    parse(p)
    return config
}

read_from_file :: proc(path: string) -> (config: ^Config = nil, ok := false) #optional_ok {
    data, success := os.read_entire_file_from_filename(path)
    if success {
        return read_from_string(string(data), path), true
    }
    return
}