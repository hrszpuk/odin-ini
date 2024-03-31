package ini

import "core:os"
import "core:fmt"

ErrorMode :: enum {
    IGNORE,                 // Will ignore the error and continue the program
    WARN_ON_ERROR,          // Will print an error message and continue the program
    WARN_AND_THROW_ON_ERROR,// Will print an error message, throw an error, and continues the program (default)
    THROW_ON_ERROR,         // Will throw an error (which may be handled programmatically) and continues the program
    PANIC_ON_ERROR,         // Will print an error message and stop the program
}

Error :: struct {
    message: string,
    line: int,
    column: int,
    file: string,
}

// Depending on the error mode, this will either throw an error, print a warning, do nothing, or stop the program.
throw_error :: proc(message := "UH OH RAGGY!", line: int, column: int, file: string) -> Maybe(Error) {
    switch GlobalOptions.ErrorHandling.Mode {
    case .IGNORE: return nil
    case .WARN_ON_ERROR:
        fmt.println("[odin-ini] WARNING %s@(%d:%d): %s", file, line, column, message)
        return nil
    case .WARN_AND_THROW_ON_ERROR:
        fmt.println("[odin-ini] WARNING %s@(%d:%d): %s", file, line, column, message)
        return Error{message, line, column, file}
    case .THROW_ON_ERROR: return Error{message, line, column, file}
    case .PANIC_ON_ERROR:
        fmt.panicf("[odin-ini] PANIC %s@(%d:%d): %s", file, line, column, message)
   }
}