package ini

Parser :: struct {
    Config: Config,
    tokens: [dynamic]Token,
    pos: int,
    content: string,
    line: int,
    col: int
}

parse :: proc(content: string) {
    p := lex(content)

}

parseSection :: proc(p: Parser) {

}

parseKey :: proc(p: Parser) {

}

parseValue :: proc(p: Parser) {

}