package ini

import "core:os"
import "core:strings"
import "core:fmt"

// Converts an ini config to a string (key=value, [section], etc)
write_to_string :: proc(c: ^Config, prefix := false) -> string {
    keys := strings.builder_make_none()
    defer strings.builder_destroy(&keys)

    sections := strings.builder_make_none()
    defer strings.builder_destroy(&sections)

    for key, value in c.keys {
        if value.keys != nil {
            strings.write_string(&sections, "\n[")
            if prefix {
                section_head := fmt.aprintf("%s.%s", c.value, value.value)
                strings.write_string(&sections, section_head)
                new_value := fmt.aprintf("%s.%s", c.value, value.value)
                delete(value.value)
                value.value = new_value
                delete(section_head)
            } else {
                strings.write_string(&sections, value.value)
            }
            strings.write_string(&sections, "]\n")
            section := write_to_string(value, true)
            strings.write_string(&sections, section)
            delete(section)
        } else {
            strings.write_string(&keys, key)
            strings.write_string(&keys, "=")
            strings.write_string(&keys, value.value)
            strings.write_string(&keys, "\n")
        }
    }

    strings.write_string(&keys, strings.to_string(sections))

    return strings.clone(strings.to_string(keys))
}

write_to_file :: proc(c: ^Config, filename := "config.ini") {

}

write_to_handle :: proc(c: ^Config, h: os.Handle) {

}

write_to_json :: proc(c: ^Config) -> string {
    return ""
}