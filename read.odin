package ini

load_from_string :: proc(content: string, name := "config") -> ^Config {
    config := new_config(name)
    tokens := lex(content)
    parse(tokens, config)
}
