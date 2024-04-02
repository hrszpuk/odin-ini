package ini

import "core:fmt"

// TODO update for new config struct (no more Section)
Parser :: struct {
    pos: int,
    tokens: [dynamic]Token,
    config: ^Config,
    section: ^Config,
}

new_parser :: proc(tokens: [dynamic]Token, config: ^Config) -> ^Parser {
    p := new(Parser)
    p.pos = 0
    p.tokens = tokens
    p.config = config
    p.section = nil
    return p
}

parse :: proc(p: ^Parser) {
    t: Token
    for p.pos < len(p.tokens) {
        t = p.tokens[p.pos]
        #partial switch t.type {
        case .LSB: parse_section(p)
        case .ID: parse_key(p)
        case .EOL: p.pos += 1
        case .EOF: return
        case:
            fmt.println("Unexpected token: ", t)
            p.pos += 1 // TODO Errors
        }
    }
}

parse_key :: proc(p: ^Parser) {
    key := p.tokens[p.pos].value
    p.pos += 1
    if p.tokens[p.pos].type != .DELIMITER {
        fmt.println("Expected delimiter after key")
        return
    }
    p.pos += 1
    value := p.tokens[p.pos].value
    p.pos += 1

    if p.section == nil {
        set(p.config, key, value)
    } else {
        set(p.section, key, value)
    }
}

parse_section :: proc(p: ^Parser) {
    p.pos += 1
    section_name := p.tokens[p.pos].value
    p.pos += 1
    if p.tokens[p.pos].type != .RSB {
        fmt.println("Expected closing bracket")
        return
    }
    p.pos += 1
    if p.tokens[p.pos].type != .EOL {
        fmt.println("Expected newline after section")
        return
    }
    p.pos += 1
    p.section = add_section(p.config, section_name)
}