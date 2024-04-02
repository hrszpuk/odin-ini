package basic

import ini "../.."
import "core:fmt"

main :: proc() {
    config := ini.read_from_file("../../tests/keys_and_sections.ini")

    ini.set(config, "wife", "Monica")

    children := ini.add_section(config, "children")
    ini.set(children, "daughter", "Jessica")
    ini.set(children, "son", "Billy")

    fmt.println(ini.write_to_string(config))
}