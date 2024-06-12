package ini

import "core:fmt"
import "core:os"
import "core:log"

read_from_string :: proc(content: string, name := "config") -> ^Config {
    log.debugf("Processing string of length %d", len(content))
    config := new_config(name)

    l := new_lexer(content)
    defer free(l)
    defer delete(l.input)

    tokens := lex(l)

    p := new_parser(tokens, config)
    defer free(p)

    parse(p)

    log.debug("Deleting dynamic token array")
    for token in tokens {
        if token.type == .IDENTIFIER {
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
        log.debugf("Successfully read %d bytes from %s", len(data), path)
        return read_from_string(string(data), path), true
    }
    log.errorf("Could not read from %s", path)
    return
}
