package ini

import "core:fmt"
import "core:os"

read_from_string :: proc(content: string, name := "config") -> ^Config {
    config := new_config(name)

    l := new_lexer(content)
    defer free(l)
    defer delete(l.input)

    tokens := lex(l)

    p := new_parser(tokens, config)
    defer free(p)

    parse(p)

    for token in tokens {
        if token.type == .ID {
            delete(token.value)
        }
    }
    defer delete(tokens)

    return config
}

read_from_file :: proc(path: string) -> (config: ^Config = nil, ok := false) #optional_ok {
    data, success := os.read_entire_file_from_filename(path)
    defer delete(data)
    if success {
        return read_from_string(string(data), path), true
    }
    return
}
