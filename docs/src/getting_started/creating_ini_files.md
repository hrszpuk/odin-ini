# Creating INI files
Reading a pre-existing ini config is not the only way to use the library. You can also create a new config from scratch using the `new_config` function.

`new_config` will accept a string argument which will be the name of the config file.
This name can be overridden when we write the config to a file.
It defaults to `"config.ini"`.
```odin
package main

import "core:fmt"
import "path/to/odin-ini/"

main :: proc() {
    config := new_config("config.ini")
    defer ini.destroy_config(config)
    
    ini.set(config, "count", "42")
}

```