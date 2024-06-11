package ini

import "core:os"
import "core:strings"
import "core:fmt"
import "core:log"

// Converts an ini config to a string (key=value, [section], etc)
write_to_string :: proc(c: ^Config, prefix := false) -> string {
    if c == nil {
        log.error("Provided ^Config is nil. Returning an empty string.")
        return ""
    } else if c.keys == nil {
        log.error("Provided ^Config.key is nil. Returning an empty string.")
        return ""
    }

    // All sections come after the global keys (keys without a section, stored within the first ^Config)
    keys := strings.builder_make_none()
    defer strings.builder_destroy(&keys)

    sections := strings.builder_make_none()
    defer strings.builder_destroy(&sections)

    for key, value in c.keys {
        if value.keys != nil {
            strings.write_string(&sections, "\n")
            strings.write_rune(&sections, Options.Symbols.SectionLeft)

            // Section name appends to a "prefix" which is made up of the previous structs.
            if prefix {
                // TODO(hrs) section_head and new_value are literally the exact same... WTF?
                section_head := fmt.aprintf("%s%v%s", c.value, Options.Symbols.NestedSection, value.value)
                strings.write_string(&sections, section_head)
                new_value := fmt.aprintf("%s%v%s", c.value, Options.Symbols.NestedSection, value.value)
                delete(value.value)

                // TODO(hrs) directly modifying the values means post-serialisation values will be different... If you serialise twice you'll get double the nesting.
                // Perhaps "prefix" could be a string of previous nesting? Override it for each new section/nested section.

                log.debugf("Applied nesting prefix to %s (will generate as %s)", value.value, new_value)
                value.value = new_value
                delete(section_head)
            } else {
                strings.write_string(&sections, value.value)
            }
            strings.write_rune(&sections, Options.Symbols.SectionRight)
            strings.write_string(&sections, "\n")
            section := write_to_string(value, true)
            strings.write_string(&sections, section)
            log.debugf("Generated section from %v", value)

            delete(section)
        } else {
            strings.write_string(&keys, key)
            strings.write_rune(&keys, Options.Symbols.Delimiter)
            strings.write_string(&keys, value.value)
            strings.write_string(&keys, "\n")
            log.debugf("Generated key value pair from '%s' and '%s'", key, value.value)
        }
    }

    strings.write_string(&keys, strings.to_string(sections))

    return strings.clone(strings.to_string(keys))
}

// Write the ini.Config to a file at the given path.
// If no file is found one will be created.
write_to_file :: proc(c: ^Config, filename: string) -> bool {
    out := write_to_string(c)
    defer delete(out)
    bytes := transmute([]u8)out
    result := os.write_entire_file(filename, bytes)
    if result {
        log.debugf("Successfully wrote %d bytes to file %s", len(bytes), filename)
    } else {
        log.errorf("Failed to write %d bytes to file %s", len(bytes), filename)
    }
    return result
}

// Converts an ini.Config into a valid Json string.
// "key = value" becomes "key":"value",
// "[section]" becomes "section":{ ... },
// This will not "pretty print" the string. It will all be on a single line.
write_to_json :: proc(c: ^Config) -> string {
    if c == nil {
        log.error("Provided ^Config is nil. Returning an empty string.")
        return ""
    } else if c.keys == nil {
        log.error("Provided ^Config.key is nil. Returning an empty string.")
        return ""
    }

    output := strings.builder_make_none()
    defer strings.builder_destroy(&output)

    strings.write_string(&output, "{")

    for key, value in c.keys {
        if value.keys == nil {
            // Handles key = value
            strings.write_string(&output, "\"")
            strings.write_string(&output, key)
            strings.write_string(&output, "\"")
            strings.write_string(&output, ":")
            strings.write_string(&output, "\"")
            strings.write_string(&output, value.value)
            strings.write_string(&output, "\"")
            strings.write_string(&output, ",")
            log.debugf("Generated key value pair from '%s' and '%s'", key, value.value)
        } else {
            // Handles [section]
            strings.write_string(&output, "\"")
            strings.write_string(&output, key)
            strings.write_string(&output, "\"")
            strings.write_string(&output, ":")
            section := write_to_json(value)
            strings.write_string(&output, section)
            delete(section)
            strings.write_string(&output, ",")
            log.debugf("Generated section from %v", value)
        }
    }

    strings.pop_rune(&output) // pop removes a redundent comma at the end of each section (kinda dumb)
    strings.write_string(&output, "}")

    return strings.clone(strings.to_string(output))
}