# Modifying INI Files
You've already seen some of the modification procedures in the previous examples. Here are some more examples of how you can modify an INI file:
```odin
package main

import "core:fmt"
import "path/to/odin-ini/"

main :: proc() {
    config := ini.read_from_file("config.ini")
    defer ini.destroy_config(config)
    
    // Set a key-value pair
    ini.set(config, "count", "42")  // Internally this is handled by `set_key`
    
    // Set a key-value pair in a section
    // If a section doesn't exist it will be created
    ini.set(config, "section", "key", "value") // Internally this is handled by `set_section_key`
    
    // Add a new section
    // If a section already exists it will be overwritte
    // Returns a pointer to the new section that can be used in `set` directly
    section := ini.add_section(config, "new_section")
    
    // Set a key-value pair in the new section
    ini.set(section, "key", "value")
    
    // Remove a key-value pair
    ini.remove(config, "count") // Internally this is handled by `remove_key`
    
    // Remove a key-value pair from a section
    ini.remove(config, "section", "key") // Internally this is handled by `remove_section_key`
    
    // Remove a section and all its key-value pairs
    ini.remove_section(config, "new_section")
    
    // Write the config to a file
    ini.write_to_file(config)
}
```