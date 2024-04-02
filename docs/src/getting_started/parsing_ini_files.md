# Parsing INI files
To parse an INI file, the library first reads the file and produces lexical tokens. Then it parses the tokens into a pointer to a [Config](../api_reference/config.md) struct.
You may do this yourself using the following functions: `new_lexer`, `lex`, `new_parser`, and `parse`.

However, the library provides a number of helper functions that make this process easier:
- `read_from_string` :
- `read_from_file`
- `read_from_reader`
- `read_from_bytes`

```odin
package main

import "core:fmt"
import "path/to/odin-ini/" 

main :: proc() {
    config := ini.read_from_file("config.ini") // Empty ini config
    defer ini.destroy_config(config) // Don't forget to free the memory!
    
    // Modifying the config
    ini.set(config, "count", "42")
    ini.set(config, "name", "John Doe")
    
    // Adding a section to the config
    animals := ini.add_section(config, "animals")
    ini.set(animals, "dog", "Rex")
    ini.set(animals, "cat", "Whiskers")
    
    // Printing the config out
    out := ini.write_to_string(config)
    fmt.println(out)
}
```
output:
``` 
count=42
name=John Doe

[animals]
dog=Rex
cat=Whiskers
```