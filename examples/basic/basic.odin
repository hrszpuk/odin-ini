package basic

import ini "../.."
import "core:fmt"

main :: proc() {
    config := ini.read_from_string("a=1\nb=2\nabc=jk40f984ejwsf osrgflfidjg\n")
    ini.set(config, "c", "3")
    ini.set(config, "d", "4")
    fmt.println(ini.write_to_string(config))
}