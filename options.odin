package ini

import "core:bufio"

// Ini is not standardised. Therefore I've let the user interchange symbols and rules that will apply during pasing/serialisation.
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

        // Parsing
        AllowEmptyValues: bool,         // Whether empty values are allowed or not (default: true)
        AllowEmptySections: bool,       // Whether empty sections are allowed or not (default: true)
        AllowNestedSections: bool,      // Whether nested sections are allowed or not (default: true)
        AllowSpacesInKeys: bool,        // Whether spaces are allowed to be a part of keys or not (default: false)
        AllowSpacesInValues: bool,      // Whether spaces are allowed to be a part of values or not (default: true)
        AllowDuplicateKeys: bool,      // Whether duplicate keys are ignored or not (default: false)
        AllowDuplicateSections: bool,  // Whether duplicate sections are ignored or not (default: false)

        IgnoreCaseSensitivity: bool,    // Whether case sensitivity is ignored or not (default: false)
        IgnoreDelimiterPadding: bool,   // Whether delimiter padding is ignored or not (default: true)
        IgnoreSectionNamePadding: bool, // Whether section name padding is ignored or not (default: true)
        IgnoreValueQuotes: bool,        // Whether the quotes around a value are counted as part of the value or not (default: true)

        IgnoreComments: bool,           // Whether to ignore comments when parsing (default: false).

        // Generation
        PaddingSymbol: rune,                        // The symbol used for padding (default: ' ')
        DelimiterPaddingAmount: uint,               // The amount of padding around the delimiter (default: 1)
        SectionNamePaddingAmount: uint,             // The amount of padding around the delimiter (default: 1)
        BeforeSectionLinePaddingAmount: uint,       // The amount of lines placed before a section header (default: 1)
        StatementCommentPaddingAmount: uint,        // The amount of padding before a comment starts after a statement (default: 1)
        EmptyLineCommentPaddingAmount: uint,        // The amount of padding before a comment starts on an empty line (default: 0)

        GenerateComments: bool,                     // Whether to generate comments or not (default: true)
        GenerateCommentsJson: bool,                 // Whether to generate comments in json or not (default: false)
        GenerateCommentsNameJson: string,           // The name of the comment field if generating in json (default: "__comment__")
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

        false,

        ' ',
        1,
        0,
        1,
        1,
        0,

        true,
        false,
        "__comment__",
    },
    false, // Debug
}
