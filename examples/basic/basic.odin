package basic

import ini "../.."
import "core:fmt"

main :: proc() {

    ini.Options.Symbols.NestedSection = '/'
    config := ini.new_config("config")
    defer ini.destroy_config(config)

    ini.set(config, "wife", "Monica")

    section := ini.add_section(config, "children")
    ini.set(section, "kevin", "kevin")

    section_nested := ini.add_section(section, "grandchildren")
    ini.set(section_nested, "Anna", "Anna")

    section_nested2 := ini.add_section(section, "grandchildren2")
    ini.set(section_nested2, "Anna2", "Anna2")

    section_nested3 := ini.add_section(section_nested2, "grandchildren3")
    ini.set(section_nested3, "Anna3", "Anna2")

    ini.write_to_file(config, "test.ini")

}