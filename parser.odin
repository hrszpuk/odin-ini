package ini
/*
Parser :: struct {
    pos: int,
    tokens: [dynamic]Token,
    config: ^Config,
    section: string,
}

new_parser :: proc(tokens: [dynamic]Token, config: ^Config) -> ^Parser {
    p := new(Parser)
    p.pos = 0
    p.tokens = tokens
    p.config = config
    p.section = nil
    return p
}

parse :: proc(tokens: [dynamic]Token, config: ^Config) {
    pos := 0
    for pos < len(tokens) {
        t := tokens[pos]
        switch t.Type {
        case .LB: parse_section(&tokens, &pos, config)
        case .KEY: parse_key(&tokens, &pos, config)
        case:
            pos += 1 // TODO Errors
        }
    }
}

parse_section :: proc(tokens: ^[dynamic]Token, pos: ^int, config: ^Config) {


}*/