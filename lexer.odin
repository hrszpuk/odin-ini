package ini

import "core:fmt"
import "core:unicode/utf8"

// Lexer will take the INI text and convert it to a list of tokens.
// "key = value" = [Token{"key", .IDENTIFIER, ...}, Token{"=", .DELIMITER, ...}, Token{"value", .IDENTIFIER, ...}]
Lexer :: struct {
    tokens: [dynamic]Token,
    input: []rune,
    pos: int,
    line: int,
    col: int,
}

// Creates a new lexer with the given input and returns a pointer to it.
new_lexer :: proc(input: string) -> ^Lexer {
    l := new(Lexer)
    l.tokens = make([dynamic]Token, 0, len(input)/2)
    l.input = utf8.string_to_runes(input)
    l.pos = 0
    l.line = 1
    l.col = 0
    return l
}

// Produces the dynamic array of tokens from the input stored in the lexer struct
lex :: proc(l: ^Lexer) -> [dynamic]Token {
    c: rune // Current character

    for l.pos < len(l.input) {

        // Most symbols can be directly added, identifiers and comments are lexed in their own functions
        switch c = next(l); c {

        case Options.Symbols.Comment: // Defaults to ;
            append(&l.tokens, lexId(l))

        case Options.Symbols.SectionRight: // Defaults to ]
            s, i := utf8.encode_rune(Options.Symbols.SectionRight)
            append(&l.tokens, Token{.SECTION_RIGHT, string(s[:i]), l.line, l.col})

        case Options.Symbols.SectionLeft: // Defaults to [
            s, i := utf8.encode_rune(Options.Symbols.SectionLeft)
            append(&l.tokens, Token{.SECTION_LEFT, string(s[:i]), l.line, l.col})

        case Options.Symbols.Delimiter: // Defaults to =
            s, i := utf8.encode_rune(Options.Symbols.Delimiter)
            append(&l.tokens, Token{.DELIMITER, string(s[:i]), l.line, l.col})

        case '\n':
            append(&l.tokens, Token{.EOL, "\n", l.line, l.col})

        // Ignore whitespace
        case ' ', '\t', '\r':
            break

        case:
            append(&l.tokens, lexId(l))
        }
    }

    append(&l.tokens, Token{.EOF, "", l.line, l.col})

    return l.tokens
}

// Tokenises identifiers (anything that is not whitespace or in Options.Symbols)
// This also lexs comments btw
lexId :: proc(l: ^Lexer) -> Token {
    start := l.pos - 1

    for l.pos < len(l.input) {
        c := next(l)

        if c == 0 || c == '\n' {
            back(l)
            break
        }
    }

    return Token{.IDENTIFIER, utf8.runes_to_string(l.input[start:l.pos]), l.line, l.col}
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