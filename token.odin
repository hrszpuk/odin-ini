package ini

import "core:strings"

TokenType :: enum {
    ID,             // Literally anything
    QM,             // "
    LSB,            // [
    RSB,            // ]
    BSL,            // \
    DELIMITER,      // = or :
    EOL,            // \n
    EOF             // End of file
}

Token :: struct {
    type: TokenType,
    value: string,
    line: int,
    col: int
}