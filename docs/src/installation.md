# Installation
The recommended way to install `odin-ini` is to use git submodules. This way you can easily update to the latest version of the library.

First, create a new git repository for your project if you haven't already:
```sh
git init .
``` 

Next, create an `external/` (or any other name) directory in the root of your project. This will hold all the external dependencies.

Then, add `odin-ini` as a submodule:
```sh
git submodule add https://github.com/hrszpuk/odin-ini.git external/odin-ini
```

Finally, add the `odin-ini` directory to your Odin project file:
```odin
package main

// Import the odin-ini package from path
import "external/odin-ini/"

main :: proc() {
    // Follow the documentation to find out how to use the library
    config := ini.read_from_file("config.ini");
    ini.set(config, "count", "42")
    ini.write_to_file(config);
    
    ini.destroy_config(config);
}
```
