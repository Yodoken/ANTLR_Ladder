lexer grammar ladder_lexer;

// Fragments
fragment WDEV:
    (([Dd] [Mm]) | [Dd] | ([Ee] [Mm]) | [Ee] | ([Ff] [Mm]) | [Ff] | ([Tt] [Mm]) |
     ([Cc] [Mm]) | [Cc] | [Tt] | [Ww] | ([Zz] [Ff]) | ([Tt] [Rr] [Mm])) HEX ('.' INT)?;
fragment BDEV:
    ([Rr] | [Xx] | [Yy] | ([Mm] [Rr]) | [Mm] | ([Ll] [Rr]) | [Ll] |
     [Bb] | ([Cc] [Rr]) | [Cc] | [Ww]) HEX ('_' INT)?;
fragment IDEV: [Zz] INT;
fragment FLT: '-'? (([0-9]+ '.') | ([0-9]+ '.' [0-9]+) | ('.' [0-9]+));
fragment INT: '-'? [0-9]+;
fragment HEX: [0-9a-fA-F]+;
fragment NL: ('\r' '\n'? | '\n');
fragment COMP: ('=' | '<' | '>' | '<=' | '>=' | '<>');
fragment CALCOP: ('+' | '-' | '*' | '/' | '&' | '|' | '^' | '~' | '<<' | '>>');

// Comment & spaces & line
COMMENT: ';' ~('\n'|'\r')* NL -> skip;
WS: (' ' | '\t')+ -> skip;
NEWLINE: NL;

// Keywords
INDIRECT: '*';
SEMICORON: ';';
CORON: ':';
UNKNOWN: '???';

// Instruction
INSTRUCTION:
      [Ll][Dd]COMP? | [Ll][Dd][Bb]
    | [Aa][Nn][Dd]COMP? | [Oo][Rr]COMP? | [Aa][Nn][Bb] | [Oo][Rr][Bb]
    | [Mm][Pp][Pp] | [Mm][Pp][Ss]| [Aa][Nn][Ll] | [Or][Rr][Ll] | [Ii][Nn][Vv]
    | [Oo][Uu][Tt] | [Oo][Uu][Bb] | [Ss][Ee][Tt] | [Rr][Ee][Ss] | [Kk][Ee][Ee][Pp]
    | [Ss][Aa][Dd][Dd] | [Ff][Aa][Ss][Cc] | [Ss][Mm][Oo][Vv]
    | [Ll][Dd][Aa] | [Ss][Tt][Aa] | [Aa][Dd][Dd] | [Ss][Uu][Bb] | [Mm][Uu][Ll] | [Dd][Ii][Vv]
    | [Dd][Ww] | [Mm][Oo][Vv]
    | [Cc][Aa][Ll]CALCOP | [Bb][Mm][Oo][Vv];
SUFFIX: '.' ([Uu] | [Ss] | [Dd] | [Ll] | [Ff] | ([Dd] [Ff]));

// Literal
INTEGER: [Kk#]? INT;
FLOAT: [Kk#]? (FLT | (FLT [Ee] INT) | (INT [Ee] INT));
HEXADECIMAL: [Hh$] HEX;
GLOBAL_DEVICE: WDEV | BDEV;
LOCAL_DEVICE: '@' (WDEV | BDEV);
INDEX_DEVICE: IDEV;
QUOTE: '"' -> pushMode(STRING_MODE);

// Identifier
IDENTIFIER: [A-Za-z0-9_]+;

// Mode
mode STRING_MODE;
DBLQUOTE: '""';
RQUOTE: '"' -> popMode;
NOT_ESCCHAR: . ;
