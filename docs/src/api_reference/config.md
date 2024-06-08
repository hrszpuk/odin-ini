# Config
The `Config` struct is the main data structure used to store the configuration data. 
I

The `Config` struct is defined as follows:

```odin
Config :: struct {
    name: string,
    keys: map[string]^Config,
}
```

## new_config(name: string = "config.ini") -> ^Config
Creates a new pointer to a `Config` struct.

```odin
config := ini.new_config()
```

## destroy_config(config: ^Config)
Deletes the `Config` struct and frees the memory.

```odin
ini.destroy_config(config)
```

## read_from_string(s: string) -> ^Config
Reads content from a string and parses it into the `Config` struct.

```odin
config := ini.read_from_string("[section]\nkey=value")
ini.destroy_config(config) // free config memory
```

## read_from_file(filename: string) -> ^Config
Reads content from a file and parses it into the `Config` struct.

```odin
config := ini.read_from_file("config.ini")
ini.destroy_config(config) // free config memory
```

## read_from_handle(h: os.Handle) -> ^Config
Reads data from a file handle and parses it into the `Config` struct.

```odin
file := os.open("config.ini", os.ModeRead)
config := ini.read_from_handle(file)
ini.destroy_config(config) // free config memory
```

## read_from_json(s: string) -> ^Config
Reads content from a JSON string and parses it into the `Config` struct.

```odin
config := ini.read_from_json("{\"name\":\"Jerry\",\"keys\":{\"section\":{\"name\":\"section\",\"keys\":{\"key\":\"value\"}}}}")
fmt.println(config) // prints &Config{name = "config.ini", keys = map[name = "Jerry", section=0x1D29928]}

ini.destroy_config(config) // free config memory
```

## write_to_string(c: ^Config) -> string
Writes the `Config` struct to a string.

```odin
config := ini.read_from_string("[section]\nkey=value")
s := ini.write_to_string(config)

delete(s) // free memory
ini.destroy_config(config) // free config memory
```

## write_to_file(c: ^Config) -> bool
Writes the `Config` struct to a file. Filename is stored in the `name` field of the `Config` struct.

```odin
config := ini.read_from_string("[section]\nkey=value")
config.name = "my_config.ini"
ini.write_to_file(config)
ini.destroy_config(config) // free config memory
```

## write_to_handle(c: ^Config, h: os.Handle) 
Writes the `Config` struct to a file handle.

```odin
config := ini.read_from_string("[section]\nkey=value")
file := os.open("my_config.ini", os.ModeWrite)
ini.write_to_handle(config, file)
ini.destroy_config(config) // free config memory
```

## write_to_json(c: ^Config) -> string
Writes the `Config` struct to a JSON string.

```odin
config := ini.read_from_string("[section]\nkey=value")
s := ini.write_to_json(config)

delete(s) // free memory
ini.destroy_config(config) // free config memory
```

## get{get_key}
Alias for `get_key`.

## get_key(c: ^Config, key: string) -> string
Gets the value of a key from the `Config` struct.
This can also be used to get the key of a section because internally they are `^Config`.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
value := ini.get_key(config, "n")
fmt.println(value) // prints 10

ini.destroy_config(config) // free config memory
```

## get_section(c: ^Config, section: string) -> ^Config
Gets the value of a section from a `Config` struct.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
value := ini.get_section(config, "section")
fmt.println(value) // prints &Config{name = "config.ini", keys = map[n=0x1D27A78, section=section1=0x1D29928]}

ini.destroy_config(config) // free config memory
```

## add_section(c: ^Config, section: string) -> ^Config
Adds a section to a `Config` and returns a pointer to the new section.
You can use the pointer to add new keys, or sections, to the section.

```odin
config := ini.new_config()
section := ini.add_section(config, "section")

ini.destroy_config(config) // free config memory
```

## set{set_key, set_section}
Alias for `set_key` and `set_section`.


## set_key(c: ^Config, key: string, value: string)
Sets the value of a key in the `Config` struct.
`key=value` is the same as `set(config, "key", "value")`.

```odin
config := ini.new_config()
ini.set_key(config, "key", "value")

ini.destroy_config(config)
```

## set_section(c: ^Config, key: string, section: ^Config)
Sets the value of a key in the `Config` struct to a section.
`[section]` is the same as `set(config, "section", section)`.

```odin
config := ini.new_config()
set_section(config, "section", ini.new_config()) // Adds an empty section called "section"

ini.destroy_config(config)
```

## remove(c: ^Config, key: string)
Removes a key from a `Config`. This will affect both key values and sections.

```odin 
config := ini.read_from_string("n=10\n[section]\nkey=value")
ini.remove(config, "n") // Removes the key "n" from the config file.
ini.remove(config, "section") // Removes the section "section" from the config file (this also removes the key).

ini.destroy_config(config) // free config memory
```

## pop_key(c: ^Config, key: string) -> string
Removes the key from the `Config` and returns the value of the key.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
value := ini.pop_key(config, "n") // Returns "10"

ini.destroy_config(config) // free config memory
``` 

## pop_section(c: ^Config, section: string) -> ^Config
Removes the key from the `Config` and returns the section as a `^Config`.
This is used to remove a section from a `Config`.

If this is applied to a normal key it will return a `Config` with the `name` field as the value but with no keys.
```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
value := ini.pop_section(config, "section") // Returns &Config{name = "section", keys = map[key=value]}

ini.destroy_config(config) // free config memory
```

## has_key(c: ^Config, key: string) -> bool
Checks if a config has a key with the given name.
This will return false if the key is a section.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
ini.has_key(config, "n") // Returns true
ini.has_key(config, "section") // Returns false
ini.has_key(config, "benis") // Returns false

ini.destroy_config(config) // free config memory
```

## has_section(c: ^Config, section: string) -> bool
Checks if a config has a section with the given name.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
ini.has_section(config, "section") // Returns true
ini.has_section(config, "n") // Returns false
ini.has_section(config, "benis") // Returns false

ini.destroy_config(config) // free config memory
```

## is_empty(c: ^Config) -> bool
Returns `true` if the config is empty, `false` otherwise.

```odin
config := ini.new_config()
ini.is_empty(config) // Returns true
ini.set_key(config, "key", "value")
ini.is_empty(config) // Returns false

ini.destroy_config(config) // free config memory
```

## clear(c: ^Config) 
Removes all keys and sections from the `Config`.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value
ini.clear(config) // Removes all keys and sections from the config file.

ini.destroy_config(config) // free config memory
```

## keys(c: ^Config) -> []string
Returns an array of all the keys in the `Config`.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
keys := ini.keys(config) // Returns ["n"]

ini.destroy_config(config) // free config memory
```

## values(c: ^Config) -> []string
Returns an array of all the values in the `Config`.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
values := ini.values(config) // Returns ["10", "value"]

ini.destroy_config(config) // free config memory
```

## sections(c: ^Config) -> []string
Returns an array of all the sections in the `Config`.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
sections := ini.sections(config) // Returns ["section"]

ini.destroy_config(config) // free config memory
```
