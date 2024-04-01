package ini
/*
import "core:bufio"

Options :: struct {
    Syntax: struct {
        CaseSensitiveKeys: bool,        // Whether keys are case-sensitive or not (default: false)
        CaseSensitiveSections: bool,    // Whether sections are case-sensitive or not (default: false)
        AllowEmptyValues: bool,         // Whether empty values are allowed or not (default: true)
        AllowEmptySections: bool,       // Whether empty sections are allowed or not (default: true)
        AllowEmptyFiles: bool,          // Whether empty files are allowed or not (default: true)
        AllowQuotedValues: bool,        // Whether quoted values are allowed or not (default: true)
        AllowNestedSections: bool,      // Whether nested sections are allowed or not (default: true)

        IgnoreDuplicateKeys: bool,      // Whether duplicate keys are ignored or not (default: false)
        IgnoreDuplicateSections: bool,  // Whether duplicate sections are ignored or not (default: false)
        IgnoreDelimiterPadding: bool,   // Whether delimiter padding is ignored or not (default: true)
        IgnoreSectionNamePadding: bool, // Whether section name padding is ignored or not (default: true)

        CommentSymbols: [dynamic]rune,  // Comment symbols (default: ['#', ';'])
        SectionSymbols: [dynamic]rune,  // Section symbols (default: ['[', ']'])
        DelimiterSymbols: [dynamic]rune,// Delimiter symbols (default: ['=', ':'])
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
GlobalOptions : Options = {
    { // Syntax
        CaseSensitiveKeys = false,
        CaseSensitiveSections = false,
        AllowEmptyValues = true,
        AllowEmptySections = true,
        AllowEmptyFiles = true,
        AllowQuotedValues = true,
        AllowNestedSections = true,

        IgnoreDuplicateKeys = false,
        IgnoreDuplicateSections = false,
        IgnoreDelimiterPadding = true,
        IgnoreSectionNamePadding = true,

        CommentSymbols = [dynamic]rune{'#', ';'},
        SectionSymbols = [dynamic]rune{'[', ']'},
        DelimiterSymbols = [dynamic]rune{'=', ':'},

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
*/