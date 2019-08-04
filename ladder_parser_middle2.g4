parser grammar ladder_parser_middle2;
options { tokenVocab=ladder_lexer_middle2; }

input: mnemonics;
mnemonics: mnemonic*;
mnemonic: instruction operand* endl;
instruction: INST | INST SUFFIX;
operand: literal | offset_device | global_device | local_device | indirect_device | unknown | identifier;

offset_device: index_device | (global_device | local_device | indirect_device) CORON (literal | index_device);
indirect_device: INDIRECT (global_device | local_device);
global_device: GLOBAL_DEVICE;
local_device: LOCAL_DEVICE;
index_device: INDEX_DEVICE;
unknown: UNKNOWN;

literal: hex_literal | float_literal | int_literal | string_literal;

hex_literal: HEXADECIMAL;
float_literal: FLOAT;
int_literal: INTEGER;

string_literal: QUOTE chars RQUOTE;
chars: (DBLQUOTE | NOT_ESCCHAR)*;
endl: EOF | NEWLINE+;

identifier: LABEL;
