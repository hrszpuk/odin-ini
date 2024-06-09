package ini

import "core:bufio"

// Ini is not standardised. Therefore I've given the programmer the ability to interchange symbols and rules.
IniOptions :: struct {

    // Symbols
    // - These are the symbols used during (de)serialisation.
    Symbols: struct {
        Delimiter: rune,          // Delimiter symbol (default: '=')
        Comment: rune,            // Comment symbol (default: ';')
        SectionLeft: rune,        // Section left symbol (default: '[')
        SectionRight: rune,       // Section right symbol (default: ']')
        NestedSection: rune,      // Nested section symbol (default: '.')

        // Examples:
        // [section]
        // key = value
        // [nested.section]
        // ; this is a comment
    },

    // Rules
    // - Allows you to allow/disallow/ignore certain rules.
    Rules: struct {
        // If you are reading these rules and think there are more that could be added open an issue (https://github.com/hrszpuk/odin-ini)

        AllowEmptyValues: bool,         // Whether empty values are allowed or not (default: true)
        AllowEmptySections: bool,       // Whether empty sections are allowed or not (default: true)
        AllowNestedSections: bool,      // Whether nested sections are allowed or not (default: true)
        AllowSpacesInKeys: bool,        // Whether spaces are allowed to be a part of keys or not (default: false)
        AllowSpacesInValues: bool,      // Whether spaces are allowed to be a part of values or not (default: true)

        IgnoreCaseSensitivity: bool,    // Whether case sensitivity is ignored or not (default: false)
        IgnoreDuplicateKeys: bool,      // Whether duplicate keys are ignored or not (default: false)
        IgnoreDuplicateSections: bool,  // Whether duplicate sections are ignored or not (default: false)
        IgnoreDelimiterPadding: bool,   // Whether delimiter padding is ignored or not (default: true)
        IgnoreSectionNamePadding: bool, // Whether section name padding is ignored or not (default: true)
        IgnoreValueQuotes: bool,        // Whether the quotes around a value are counted as part of the value or not (default: true)
    },

    Debug: bool,    // Debugging mode will print debug information (default: false)
}

// These options can be changed at runtime.
Options : IniOptions = {
    { '=', ';', '[', ']', '.' },
    {
        true,
        true,
        true,
        true,
        false,

        true,
        false,
        false,
        false,
        true,
        true,
    },
    false, // Debug
}
