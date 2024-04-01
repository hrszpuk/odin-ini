package ini

import "core:strings"

TokenType :: enum {
    ID,
    LSB,
    RSB,
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