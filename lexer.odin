package ini

import "core:fmt"
import "core:unicode/utf8"

Lexer :: struct {
    tokens: [dynamic]Token,
    input: []rune,
    pos: int,
    line: int,
    col: int,
}

new_lexer :: proc(input: string) -> ^Lexer {
    l := new(Lexer)
    l.tokens = make([dynamic]Token, 0, len(input)/2)
    l.input = utf8.string_to_runes(input)
    l.pos = 0
    l.line = 1
    l.col = 0
    return l
}

lex :: proc(l: ^Lexer) -> [dynamic]Token {
    c: rune
    for l.pos < len(l.input) {
        switch c = next(l); c {
        case '\n': append(&l.tokens, Token{.EOL, "\n", l.line, l.col})
        case ';', '#': append(&l.tokens, Token{.COMMENT, lexId(l).value, l.line, l.col})
        case ']': append(&l.tokens, Token{.RSB, "]", l.line, l.col})
        case '[': append(&l.tokens, Token{.LSB, "[", l.line, l.col})
        case '=', ':': append(&l.tokens, Token{.DELIMITER, "=", l.line, l.col})
        case ' ', '\t', '\r': break
        case: append(&l.tokens, lexId(l))
        }
    }

    append(&l.tokens, Token{.EOF, "", l.line, l.col})

    return l.tokens
}

lexId :: proc(l: ^Lexer) -> Token {
    start := l.pos - 1

    for l.pos < len(l.input) {
        c := next(l)
        if c == 0 || c == '\n' || c == '[' || c == ']' || c == '=' {
            back(l)
            break
        }
    }

    return Token{.ID, utf8.runes_to_string(l.input[start:l.pos]), l.line, l.col}
}

lexComment :: proc(l: ^Lexer) -> Token {
    start := l.pos - 1

    for l.pos < len(l.input) {
        c := next(l)
        if c == 0 || c == '\n' {
            back(l)
            break
        }
    }

    return Token{.ID, utf8.runes_to_string(l.input[start:l.pos]), l.line, l.col}
}

back :: proc(l: ^Lexer) {
    l.pos -= 1
    if l.input[l.pos] == '\n' {
        l.line -= 1
    } else {
        l.col -= 1
    }
}

next :: proc(l: ^Lexer) -> rune {
    if l.pos >= len(l.input) {
        return 0
    }

    c := l.input[l.pos]
    l.pos += 1

    if c == '\n' {
        l.line += 1
        l.col = 1
    } else {
        l.col += 1
    }

    return c
}