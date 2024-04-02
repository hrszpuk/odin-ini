# Extracting data
You can read data from a config using the `get` procedures:
- `get`: alias for `get_key`
- `get_key`: get a key-value pair in the config (or section)
- `get_section`: get a section in the config
- `exists`: alias for `exists_key`
- `exists_key`: check if a key exists in the config
- `exists_section`: check if a section exists in the config

All of these procedures use the `optional-ok` semantics provided by Odin.

```odin
package main

import "core:fmt"
import "path/to/odin-ini/"

main :: proc() {
    config := ini.read_from_file("config.ini")
    defer ini.destroy_config(config)
    
    // Get a key-value pair
    count := ini.get(config, "count") or_else "0"
    
    // Get a key-value pair from a section
    section, ok := ini.get_section(config, "section")
    if ok {
        key, ok := ini.get(section, "key")
    }
    
    // Check if a key exists
    if ini.exists(config, "count") {
        fmt.println("Count exists")
    }
    
    // Check if a section exists
    if ini.exists_section(config, "section") {
        fmt.println("Section exists")

        // Check if a key exists in a section
        if ini.exists(section, "key") {
            fmt.println("Key exists in section")
        }
    }
}

```