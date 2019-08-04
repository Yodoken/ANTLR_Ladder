lexer grammar ladder_lexer_middle2;

//fragment DEV: [A-Za-z]{1,3} HEX (('_' | '.') INT)?;
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

COMMENT: ';' ~('\n'|'\r')* NL -> skip;
WS: (' ' | '\t')+ -> skip;
NEWLINE: NL;

INDIRECT: '*';
SEMICORON: ';';
CORON: ':';
UNKNOWN: '???';

INST: ('LD' | 'LDA' | 'SADD' | 'FASC' | 'SMOV' | 'CAL' | 'BMOV') [<>=+\-*/&|^~]*;
SUFFIX: '.' ([Uu] | [Ss] | [Dd] | [Ll] | [Ff] | ([Dd] [Ff]));
INTEGER: [Kk#]? INT;
FLOAT: [Kk#]? (FLT | (FLT [Ee] INT) | (INT [Ee] INT));
HEXADECIMAL: [Hh$] HEX;
GLOBAL_DEVICE: WDEV | BDEV;
LOCAL_DEVICE: '@' (WDEV | BDEV);
INDEX_DEVICE: IDEV;
QUOTE: '"' -> pushMode(STRING_MODE);

LABEL: [A-Za-z0-9_]+;

mode STRING_MODE;
DBLQUOTE: '""';
RQUOTE: '"' -> popMode;
NOT_ESCCHAR: . ;
