package ini

import "core:strings"

write_to_string :: proc(c: ^Config) -> string {
    s := strings.builder_make_none()
    defer strings.builder_destroy(&s)

    for key, value in c.keys {
        strings.write_string(&s, key)
        strings.write_string(&s, "=")
        strings.write_string(&s, value)
        strings.write_string(&s, "\n")
    }

    for section in c.sections {
        strings.write_string(&s, "\n[")
        strings.write_string(&s, section.name)
        strings.write_string(&s, "]\n")

        for key, value in section.keys {
            strings.write_string(&s, key)
            strings.write_string(&s, "=")
            strings.write_string(&s, value)
            strings.write_string(&s, "\n")
        }
    }

    return strings.clone(strings.to_string(s))
}