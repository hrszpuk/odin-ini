# odin-ini
A fast, easy to use, and customisable, ini serialiser and deserialiser.

```odin 
package main

import ini "path/to/odin-ini"
import "core:fmt"

main :: proc() {
    config := ini.read_from_file("config.ini")
    
    ini.set(config, "example", "yes")
    ini.get("example") // "yes"
    
    names := ini.add_section(config, "names")
    ini.set(names, "Dick Hunter")
    ini.set(names, "Mike Hunt")
    
    s := ini.write_to_string(config)
    fmt.println(s)
    
    delete(s)
    ini.destroy_config(config)
}
```

## Installation and usage
>[!NOTE]
> More information about Odin ini including installation and usage can be found in the [project's documentation](https://hrszpuk.github.io/odin-ini).

### Installing as a submodule


### List of structures


### List of functions


## Contributing 
