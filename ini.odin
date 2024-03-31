package ini

Config :: struct {
    name: string,
    keys: map[string]string,
    sections: [dynamic]^Section,
}

new_config :: proc(name: string) -> ^Config {
    p := new(Config)
    p.name = name
    p.keys = make(map[string]string)
    p.sections = make([dynamic]^Section, 0)

    return p
}

set :: proc{set_key, set_section}

set_key :: proc(c: ^Config, key: string, value: string) {
    c.keys[key] = value
}

set_section :: proc(c: ^Config, key: string, value: ^Section) {
    if value == nil {
        return
    }
    append(&c.sections, value)
}

// Gets the value of a key in the config.
get :: proc(c: ^Config, key: string) -> string {
    return c.keys[key]
}

// Finds a section by name and returns a pointer to it.
// If no section matches the name, it returns nil.
get_section :: proc(c: ^Config, name: string) -> ^Section {
    for s in c.sections {
        if s.name == name {
            return s
        }
    }
    return nil
}

