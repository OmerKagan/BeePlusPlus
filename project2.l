/* project2.l */
alphabetic [A-Za-z]
digit [0-9]
alphanumeric ({alphabetic}|{digit})
url ({alphanumeric}|\.)
boolean (True|False)
type (int|double|char|bool|string|url)
%%
bout return (B_OUT);
bin return (B_IN);
if return (IF);
elif return (ELSE_IF);
else return (ELSE);
return return (RETURN); 
http\:\/\/{url}+ return (URL);
for return (FOR);
while return (WHILE);
connect return (CONNECT);
send return (SEND);
to return (TO);
receive return (RECEIVE);
from return (FROM);
and return (AND);
or return (OR);
void return (VOID);
{type} return (TYPE_ID);
\"(.)*\" return (STRING);
{boolean} return (BOOLEAN);
{alphabetic}{alphanumeric}* return (IDENTIFIER);
\'(.)\' return (CHAR);
(-)?{digit}+ return (INT);
(\-)?{digit}*(\.)?{digit}+ return (DOUBLE);
\( return (LP);
\) return (RP);
\, return (COMMA);
\. return (DOT);
\{ return (L_CB);
\} return (R_CB);
\<\- return (BOUT_OP);
\-\> return (BIN_OP);
\= return (ASSIGN_OP);
\=\= return (EQ_OP);
\!\= return (NOT_EQ_OP);
\< return (SMALLER_THAN);
\> return (GREATER_THAN);
\<\= return (SMALLER_OR_EQUAL);
\>\= return (GREATER_OR_EQUAL);
\! return (NOT_OP);
\' return (SINGLE_QUOTE);
\" return (DOUBLE_QUOTE);
\% return (MODULO_OP);
\/\/ return (COMMENT_OP);
\/\- return (MULTILINE_COMMENT_START);
\-\/ return (MULTILINE_COMMENT_END);
\/ return (DIVISION_OP);
\* return (MULTIPLICATION_OP);
\- return (SUBSTRACTION_OP);
\+ return (PLUS_OP);
\n {extern int lineno; lineno++; return (NEW_LINE);}
\t return (TAB);
\; return (SEMI_COLON);
. return (yytext[0])
%%
int yywrap() {return 1;}
