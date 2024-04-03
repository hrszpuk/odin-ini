package ini

import "core:bufio"

IniOptions :: struct {
    Syntax: struct {
        AllowEmptyValues: bool,         // Whether empty values are allowed or not (default: true)
        AllowEmptySections: bool,       // Whether empty sections are allowed or not (default: true)
        AllowQuotedValues: bool,        // Whether quoted values are allowed or not (default: true)
        AllowNestedSections: bool,      // Whether nested sections are allowed or not (default: true)

        IgnoreCaseSensitivity: bool,    // Whether case sensitivity is ignored or not (default: false)
        IgnoreDuplicateKeys: bool,      // Whether duplicate keys are ignored or not (default: false)
        IgnoreDuplicateSections: bool,  // Whether duplicate sections are ignored or not (default: false)
        IgnoreDelimiterPadding: bool,   // Whether delimiter padding is ignored or not (default: true)
        IgnoreSectionNamePadding: bool, // Whether section name padding is ignored or not (default: true)

        NestedSectionSymbol: rune,      // Nested section symbol (default: '.')
    },

    Parsing: struct {
        ParseComments: bool,            // Whether comments are parsed or not (default: false)
        Multithreading: bool,           // Whether parsing is multithreaded or not (default: false)
    },

    Serialization: struct {
        SerializeComments: bool,        // Whether comments are serialized or not (default: false)
        PadDelimiters: bool,            // Whether delimiters are padded or not (default: false)
        ForceQuotes: bool,              // Whether values are forced to be quoted or not (default: false)
        QuoteEmptyValues: bool,         // Whether empty values are quoted or not (default: false)
        RemoveEmptyValues: bool,        // Whether empty values are removed or not (default: false)
        Multithreading: bool,           // Whether serialization is multithreaded or not (default: false)
    },

    ErrorHandling: struct {
        Mode: ErrorMode,                // Error handling mode (default: ErrorMode.WARN_ON_ERROR)
        PrintErrors: bool,              // Whether errors are printed or not (default: false)
        Output: bufio.Writer,           // Output writer for errors (default: os.Stderr)
    },

    Debug: bool,                        // Debugging mode will print debug information (default: false)
}

// Default, global options for the library.
// These options can be changed at runtime.
Options : IniOptions = {
    { // Syntax
        AllowEmptyValues = true,
        AllowEmptySections = true,
        AllowQuotedValues = true,
        AllowNestedSections = true,

        IgnoreCaseSensitivity = false,
        IgnoreDuplicateKeys = false,
        IgnoreDuplicateSections = false,
        IgnoreDelimiterPadding = true,
        IgnoreSectionNamePadding = true,

        NestedSectionSymbol = '.',
    },
    { // Parsing
        ParseComments = false,
        Multithreading = false,
    },
    { // Serialization
        SerializeComments = false,
        PadDelimiters = false,
        ForceQuotes = false,
        QuoteEmptyValues = false,
        RemoveEmptyValues = false,
        Multithreading = false,
    },
    { // ErrorHandling
        Mode = ErrorMode.WARN_ON_ERROR,
        PrintErrors = false,
        Output = {},
    },

    false, // Debug
}
