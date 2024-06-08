package ini

import "core:fmt"

// Ini Config Type
// .value is the value of an entry stored in the config (or section of the config), or the name of the config.
// .keys is null when value is the value of an entry, or filled with entries (a section).
Config :: struct {
    value: string,
    keys: map[string]^Config,
}

// Creates a new ini config and returns a pointer to it.
new_config :: proc(name: string) -> ^Config {
    p := new(Config)
    p.value = name
    p.keys = make(map[string]^Config)

    return p
}

// Deletes all keys and values in the config, and the config itself.
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

// Adds a new section to the given config and returns a pointer to it.
add_section :: proc(c: ^Config, name: string) -> ^Config {
    s := new(Config)
    s.value = name
    s.keys = make(map[string]^Config)
    c.keys[name] = s
    return s
}

// Sets the value of a given key.
set :: proc{set_key, set_section}

// Sets the value of a given key.
set_key :: proc(c: ^Config, key: string, value: string) {
    c.keys[key] = new(Config)
    c.keys[key].value = value
}

// Sets the value of a given key (specifically for sections).
set_section :: proc(c: ^Config, key: string, value: ^Config) -> bool {
    if value == nil {
        return false
    }
    c.keys[key] = value
    return true
}

// Returns the value of a given key. Does not support returning sections.
get :: proc{get_key}

// Returns the value of a key in the config. Does not support returning sections.
get_key :: proc(c: ^Config, key: string) -> string {
    return c.keys[key].value
}

// Finds a section by name and returns a pointer to it.
// If no section matches the name, it returns nil.
get_section :: proc(c: ^Config, name: string) -> ^Config {
    return c.keys[name]
}

