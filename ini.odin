package ini

import "core:fmt"

Config :: struct {
    name: string,
    keys: map[string]^Config,
    safe: bool,
}

new_config :: proc(name: string) -> ^Config {
    p := new(Config)
    p.name = name
    p.keys = make(map[string]^Config)

    return p
}

destroy_config :: proc(c: ^Config) {
    for k, v in c.keys {
        delete(k)
        if v.keys == nil {
            delete(v.name)
            free(v)
            continue
        } else {
            destroy_config(v)
        }
    }
    delete(c.keys)
    free(c)
}

add_section :: proc(c: ^Config, name: string) -> ^Config {
    s := new(Config)
    s.name = name
    s.keys = make(map[string]^Config)
    c.keys[name] = s
    return s
}

set :: proc{set_key, set_section}

set_key :: proc(c: ^Config, key: string, value: string) {
    c.keys[key] = new(Config)
    c.keys[key].name = value
}

set_section :: proc(c: ^Config, key: string, value: ^Config) -> bool {
    if value == nil {
        return false
    }
    c.keys[key] = value
    return true
}

get :: proc{get_key}

// Gets the value of a key in the config.
get_key :: proc(c: ^Config, key: string) -> string {
    return c.keys[key].name
}

// Finds a section by name and returns a pointer to it.
// If no section matches the name, it returns nil.
get_section :: proc(c: ^Config, name: string) -> ^Config {
    return c.keys[name]
}

