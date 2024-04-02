# Serializing INI files
To serialize an INI file, the library first serializes the config into a string. Then it writes the string to a file.
You may do this yourself using the following functions:
- `write_to_string`
- `write_to_file`
- `write_to_writer`
- `write_to_map`
- `write_to_array`

```odin 
package main

import "core:fmt"
import "path/to/odin-ini/"

main :: proc() {
    config := ini.read_from_file("config.ini")
    defer ini.destroy_config(config)
    
    // Write the config to a string
    out := ini.write_to_string(config)
    fmt.println(out)
    
    // Write the config to a file
    ini.write_to_file(config)
    
    // you may (optionally) override the name of the file by providing a section argument
    ini.write_to_file(config, "new_config.ini")
}
```