package ini

import "core:fmt"

read_from_string :: proc(content: string, name := "config") -> ^Config {
    config := new_config(name)
    l := new_lexer(content)
    tokens := lex(l)
    fmt.println(tokens)
    //parse(tokens, config)
    return config
}
