package ini

import "core:strings"

TokenType :: enum {
    KEY,
    VALUE,
    LB,
    RB,
    EQUALS,
    COLON,
    EOL,
    EOF

}

Token :: struct {
    type: TokenType,
    value: string,
    line: int,
    col: int
}

lex :: proc(input: string) -> [dynamic]Token {
    tokens: [dynamic]Token
    line: int = 1
    col: int = 1
    i: int = 0

    for i < len(input) {
        switch input[i] {
            case ':':
                append(&tokens, Token{.COLON, ":", line, col})
                col += 1
                i += 1
            case '=':
                append(&tokens, Token{.EQUALS, "=", line, col})
                col += 1
                i += 1
            case '[':
                append(&tokens, Token{.LB, "[", line, col})
                col += 1
                i += 1
            case ']':
                append(&tokens, Token{.RB, "]", line, col})
                col += 1
                i += 1
            case '#', ';':
                col += 1
                i += 1
            case '\n':
                append(&tokens, Token{.EOL, "\n", line, col})
                line += 1
                col = 1
                i += 1
            case ' ', '\t':
                col += 1
                i += 1
            case:
                buffer := strings.builder_make_none()
                for i < len(input) && (input[i] != ' ' && input[i] != '\t' && input[i] != '\n' && input[i] != 0) {
                    strings.write_byte(&buffer, input[i])
                    col += 1
                    i += 1
                }
                append(&tokens, Token{.KEY, strings.clone(strings.to_string(buffer)), line, col})
                col += 1
                strings.builder_destroy(&buffer)
         }
    }
    return tokens
}