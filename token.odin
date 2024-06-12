package ini

import "core:strings"

TokenType :: enum {
    IDENTIFIER,
    SECTION_LEFT,
    SECTION_RIGHT,
    COMMENT,
    DELIMITER,
    EOL,
    EOF
}

Token :: struct {
    type: TokenType,
    value: string,
    line: int,
    col: int
}