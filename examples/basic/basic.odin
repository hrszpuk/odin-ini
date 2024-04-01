package basic

import ini "../.."
import "core:fmt"

main :: proc() {
    config := ini.read_from_file("../../tests/keys.ini")
    ini.set(config, "c", "3")
    ini.set(config, "d", "4")
    fmt.println(ini.write_to_string(config))
}