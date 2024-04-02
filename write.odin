package ini

import "core:strings"

write_to_string :: proc(c: ^Config) -> string {
    keys := strings.builder_make_none()
    defer strings.builder_destroy(&keys)

    sections := strings.builder_make_none()
    defer strings.builder_destroy(&sections)

    for key, value in c.keys {
        if value.keys != nil {
            strings.write_string(&sections, "\n[")
            strings.write_string(&sections, value.name)
            strings.write_string(&sections, "]\n")
            section := write_to_string(value)
            strings.write_string(&sections, section)
            delete(section)
        } else {
            strings.write_string(&keys, key)
            strings.write_string(&keys, "=")
            strings.write_string(&keys, value.name)
            strings.write_string(&keys, "\n")
        }
    }

    strings.write_string(&keys, strings.to_string(sections))

    return strings.clone(strings.to_string(keys))
}