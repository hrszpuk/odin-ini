package basic

import ini "../.."
import "core:fmt"

main :: proc() {
    config := ini.read_from_file("../../tests/sections.ini")
    defer ini.destroy_config(config)

    ini.set(config, "wife", "Monica")

    children := ini.add_section(config, "children")
    ini.set(children, "daughter", "Jessica")
    ini.set(children, "son", "Billy")


    s := ini.write_to_string(config)
    defer delete(s)
    fmt.println(s)
}