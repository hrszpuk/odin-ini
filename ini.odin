package ini

import "core:fmt"
import "core:strings"
import "core:log"

// Ini Config Type
// .value is the value of an entry stored in the config (or section of the config), or the name of the config.
// .keys is null when value is the value of an entry, or filled with entries (a section).
Config :: struct {
    value: string,
    keys: map[string]^Config,
}

// Sections are treated the same as the whole Config.
// Added these so its more clear for anyone who does not know that fact.
Section :: Config
new_section :: proc{new_config}
destroy_section :: proc{destroy_config}

// Creates a new ini config and returns a pointer to it.
new_config :: proc(name: string) -> ^Config {
    p := new(Config)
    p.value = strings.clone(name)
    p.keys = make(map[string]^Config)
    log.debugf("Created a new config with the name '%s'.", name)
    return p
}

// Deletes all keys and values in the config, and the config itself.
destroy_config :: proc(c: ^Config) {
    if c == nil do return

    if c.keys != nil {
        for k, v in c.keys {
            if v.keys == nil {
                //delete(k)
                delete(v.value)
                free(v)
            } else {
                destroy_config(v)
            }
        }
        delete(c.keys)
    }
    delete(c.value)
    free(c)
    log.debugf("Destroyed config with the name '%s'.", c.value)
}

// Adds a new section to the given config and returns a pointer to it.
add_section :: proc(c: ^Config, name: string) -> (^Config, bool) #optional_ok {
    if c == nil {
        log.errorf("Provided ^Config is nil. Returning nil.")
        return nil, false
    } else if has_key(c, name) {
        log.errorf("Provided ^Config already contains the key '%s'. Returning nil.", name)
        return nil, false
    }

    s := new(Config)
    s.value = strings.clone(name)
    s.keys = make(map[string]^Config)

    c.keys[name] = s

    log.debugf("Added section '%s' to config '%s'.", name, c.value)
    return s, true
}

// Sets the value of a given key.
set :: proc{set_key, set_section}

// Sets the value of a given key.
set_key :: proc(c: ^Config, key: string, value: string) -> bool {
    if c == nil {
        log.errorf("Provided ^Config is nil. Returning.")
        return false
    } else if has_key(c, key) {
        log.errorf("Provided ^Config already contains the key '%s'. Returning.", key)
        return false
    }

    c.keys[key] = new(Config)
    c.keys[key].value = strings.clone(value)
    return true
}

// Sets the value of a given key (specifically for sections).
set_section :: proc(c: ^Config, key: string, value: ^Config) -> bool {
    if c == nil {
        log.errorf("Provided ^Config is nil. Returning.")
        return false
    } else if has_key(c, key) {
        log.errorf("Provided ^Config already contains the key '%s'. Returning.", key)
        return false
    } else if value == nil {
        log.errorf("Provided section (^Config) is nil. Returning.")
        return false
    }

    c.keys[key] = value
    return true
}

// Returns the value of a given key. Does not support returning sections.
get :: proc{get_key}

// Returns the value of a key in the config. Does not support returning sections.
get_key :: proc(c: ^Config, key: string) -> (string, bool) #optional_ok {
    if c == nil {
        log.errorf("Provided ^Config is nil. Cannot get key '%s'.", key)
        return "", false
    }
    return c.keys[key].value, true
}

// Finds a section by name and returns a pointer to it.
// If no section matches the name, it returns nil.
get_section :: proc(c: ^Config, name: string) -> (^Config, bool) #optional_ok {
    if c == nil {
        log.errorf("Provided ^Config is nil. Cannot get section '%s'. Returning nil.", name)
        return nil, false
    }
    return c.keys[name], true
}

// Checks if a key exists in a given config
has_key :: proc(c: ^Config, name: string) -> bool {
    if c == nil || c.keys == nil do return false
    return name in c.keys
}

// Checks if a key exists in a given config and if it is a section.
is_section :: proc(c: ^Config, name: string) -> bool {
    return has_key(c, name) && c.keys[name].keys != nil
}

// Removes a key from a config/section
remove :: proc(c: ^Config, name: string) -> bool {
    if !has_key(c, name) {
        log.warnf("Cannot remove key '%s' from config because '%s' does not exist.", name, name)
        return false
    }
    value := c.keys[name]
    destroy_config(value)
    delete_key(&c.keys, name)
    return true
}

// Removes a key from a config/section and returns the value
pop_key :: proc(c: ^Config, name: string) -> (string, bool) #optional_ok {
    if !has_key(c, name) {
        log.errorf("Cannot pop key '%s' from config because '%s' does not exist.", name, name)
        return "", false
    }
    value := c.keys[name]
    defer free(value)
    delete_key(&c.keys, name)
    return value.value, true
}

// Removes a key from a config/section
pop_section :: proc(c: ^Config, name: string) -> (^Config, bool) #optional_ok  {
    if !has_key(c, name) {
        log.errorf("Cannot pop section '%s' from config because '%s' does not exist.", name, name)
        return nil, false
    }
    value := c.keys[name]
    delete_key(&c.keys, name)
    return value, true
}