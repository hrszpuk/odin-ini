package basic

import ini "../.."
import "core:fmt"

main :: proc() {
    config := ini.read_from_file("../../tests/basic.ini")
    fmt.println(ini.write_to_string(config))
}