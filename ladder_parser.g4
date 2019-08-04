parser grammar ladder_parser;
options { tokenVocab=ladder_lexer; }

// Entry
mnemonicList: mnemonic*;

// Mnemonic
mnemonic: instruction operand* endl;
instruction: INSTRUCTION | INSTRUCTION SUFFIX;
operand: hexLiteral | floatLiteral | intLiteral | stringLiteral
    | offsetDevice | globalDevice | localDevice | indirectDevice
    | unknown
    | identifier;

// Unknown
unknown: UNKNOWN;

// Device
offsetDevice: indexDevice | (globalDevice | localDevice | indirectDevice) CORON (intLiteral | indexDevice);
indirectDevice: INDIRECT (globalDevice | localDevice);
globalDevice: GLOBAL_DEVICE;
localDevice: LOCAL_DEVICE;
indexDevice: INDEX_DEVICE;

// Literal
hexLiteral: HEXADECIMAL;
floatLiteral: FLOAT;
intLiteral: INTEGER;
stringLiteral: QUOTE chars RQUOTE;
chars: (DBLQUOTE | NOT_ESCCHAR)*;
endl: EOF | NEWLINE+;

// Identifier
identifier: IDENTIFIER;
