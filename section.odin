package ini

Section :: struct {
    name: string,
    keys: map[string]string,
}

add_section :: proc(c: ^Config, name: string) -> ^Section {
    s := new(Section)
    s.name = name
    s.keys = make(map[string]string)
    append(&c.sections, s)
    return s
}