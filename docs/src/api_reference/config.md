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


## get(c: ^Config, key: string) -> string
Gets the value of a key from the `Config` struct.
This can also be used to get the key of a section because internally they are `^Config`.

```odin
config := ini.read_from_string("n=10\n[section]\nkey=value")
value := ini.get(config, "n")

ini.destroy_config(config) // free config memory
```

## get_key


## get_section


## add_section


## set


## set_key


## set_section


## remove


## remove_key


## remove_section


## has_key


## has_section


## is_empty


## clear


## remove_all


## size


## depth


## keys


## values


## sections


## all_keys


## all_values


## all_sections


## flatten


## merge
