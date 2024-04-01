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
