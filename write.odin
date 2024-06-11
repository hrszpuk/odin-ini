package ini

import "core:os"
import "core:strings"
import "core:fmt"

// Converts an ini config to a string (key=value, [section], etc)
write_to_string :: proc(c: ^Config, prefix := false) -> string {
    if c == nil || c.keys == nil do return "" // I HOPE THIS WILL STOP THE VOICES FROM SCREAMING AT ME

    keys := strings.builder_make_none()
    defer strings.builder_destroy(&keys)

    sections := strings.builder_make_none()
    defer strings.builder_destroy(&sections)

    for key, value in c.keys {
        if value.keys != nil {
            strings.write_string(&sections, "\n")
            strings.write_rune(&sections, Options.Symbols.SectionLeft)
            if prefix {
                section_head := fmt.aprintf("%s%v%s", c.value, Options.Symbols.NestedSection, value.value)
                strings.write_string(&sections, section_head)
                new_value := fmt.aprintf("%s%v%s", c.value, Options.Symbols.NestedSection, value.value)
                delete(value.value)
                value.value = new_value
                delete(section_head)
            } else {
                strings.write_string(&sections, value.value)
            }
            strings.write_rune(&sections, Options.Symbols.SectionRight)
            strings.write_string(&sections, "\n")
            section := write_to_string(value, true)
            strings.write_string(&sections, section)
            delete(section)
        } else {
            strings.write_string(&keys, key)
            strings.write_rune(&keys, Options.Symbols.Delimiter)
            strings.write_string(&keys, value.value)
            strings.write_string(&keys, "\n")
        }
    }

    strings.write_string(&keys, strings.to_string(sections))

    return strings.clone(strings.to_string(keys))
}

// Write the ini.Config to a file at the given path.
// If no file is found one will be created (hopefully).
write_to_file :: proc(c: ^Config, filename: string) -> bool {
    out := write_to_string(c)
    defer delete(out)
    return os.write_entire_file(filename, transmute([]u8)out)
}

// Converts an ini.Config into a valid Json string.
// "key = value" becomes "key":"value",
// "[section]" becomes "section":{ ... },
write_to_json :: proc(c: ^Config) -> string {
    output := strings.builder_make_none()
    defer strings.builder_destroy(&output)

    strings.write_string(&output, "{")

    for key, value in c.keys {
        if value.keys == nil {
            strings.write_string(&output, "\"")
            strings.write_string(&output, key)
            strings.write_string(&output, "\"")
            strings.write_string(&output, ":")
            strings.write_string(&output, "\"")
            strings.write_string(&output, value.value)
            strings.write_string(&output, "\"")
            strings.write_string(&output, ",")
        } else {
            strings.write_string(&output, "\"")
            strings.write_string(&output, key)
            strings.write_string(&output, "\"")
            strings.write_string(&output, ":")
            section := write_to_json(value)
            strings.write_string(&output, section)
            delete(section)
            strings.write_string(&output, ",")
        }
    }

    strings.pop_rune(&output)
    strings.write_string(&output, "}")

    return strings.clone(strings.to_string(output))
}