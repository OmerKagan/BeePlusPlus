/*project2.y */
%{
#include <stdio.h>
%}
%token B_OUT
%token B_IN
%token IF
%token ELSE_IF
%token ELSE
%token RETURN
%token URL
%token FOR
%token WHILE
%token CONNECT
%token SEND
%token TO
%token RECEIVE
%token FROM
%token AND
%token OR
%token VOID
%token TYPE_ID
%token STRING
%token BOOLEAN
%token IDENTIFIER
%token CHAR
%token INT
%token DOUBLE
%token LP
%token RP
%token COMMA
%token DOT
%token L_CB
%token R_CB
%token BOUT_OP
%token BIN_OP
%token ASSIGN_OP
%token EQ_OP
%token NOT_EQ_OP
%token SMALLER_THAN
%token GREATER_THAN
%token SMALLER_OR_EQUAL
%token GREATER_OR_EQUAL
%token NOT_OP
%token SINGLE_QUOTE
%token DOUBLE_QUOTE
%token MODULO_OP
%token COMMENT_OP
%token MULTILINE_COMMENT_START
%token MULTILINE_COMMENT_END
%token DIVISION_OP
%token MULTIPLICATION_OP
%token SUBSTRACTION_OP
%token PLUS_OP
%token NEW_LINE
%token TAB
%token SEMI_COLON
%start program
%%
program: stmt_list
stmt_list: stmt SEMI_COLON
           | stmt SEMI_COLON stmt_list
stmt: if_stmt
      | elif_stmt
      | while_stmt
      | for_stmt
      | assign_stmt
      | declaration_stmt
      | decas_stmt
      | comment_stmt
      | fnc_stmt
      | connect_stmt
      | send_stmt
      | receive_stmt
      | print_stmt
      | input_stmt

if_stmt: IF logic_expr L_CB stmt_list R_CB
	| IF logic_expr L_CB stmt_list R_CB ELSE L_CB stmt_list R_CB
	| IF logic_expr L_CB stmt_list R_CB elif_stmt
	| IF logic_expr L_CB stmt_list R_CB elif_stmt ELSE L_CB stmt_list R_CB 


elif_stmt: ELSE_IF logic_expr L_CB stmt_list R_CB
	 | ELSE_IF logic_expr L_CB stmt_list R_CB elif_stmt

while_stmt: while logic_expr L_CB stmt_list R_CB

for_stmt: FOR LP decas_stmt logic_expr expr RP L_CB stmt_list R_CB 
	| FOR LP assign_stmt logic_expr op_expr RP L_CB stmt_list R_CB

assign_stmt: IDENTIFIER EQ_OP expr

<declaration_stmt>: TYPE_ID ident_list

<decas_stmt>: TYPE_ID IDENTIFIER EQ_OP  expr 

<comment_stmt>: COMMENT_OP line
	       | MULTILINE_COMMENT_START lines MULTILINE_COMMENT_END

line: STRING NEW_LINE	
lines: line
	| line lines

connect_stmt: CONNECT url_expr

send_stmt: SEND INT TO url_expr

receive_stmt: RECEIVE INT FROM url_expr

print_stmt: B_OUT BOUT_OP expr

input_stmt: B_IN BIN_OP IDENTIFIER
			
fnc_stmt: r_fnc_stmt | nor_fnc_stmt

r_fnc_stmt: TYPE_ID IDENTIFIER LP param_list RP L_CB stmt_list RETURN IDENTIFIER SEMI_COLON R_CB

nor_fnc_stmt: VOID IDENTIFIER LP param_list RP L_CB stmt_list R_CB
	      | VOID IDENTIFIER LP param_list RP L_CB stmt_list RETURN SEMI_COLON R_CB

param_list: TYPE_ID IDENTIFIER
	    | TYPE_ID IDENTIFIER COMMA param_list 

expr: op_expr | logic_expr | url_expr | primitive_fnc_expr | char_expr | string_expr

op_expr: op_expr PLUS_OP term
			  | op_expr SUBSTRACTION_OP term
			  | term

logic_expr: IDENTIFIER SMALLER_THAN IDENTIFIER
			     | IDENTIFIER GREATER_THAN IDENTIFIER
			     | IDENTIFIER EQ_OP IDENTIFIER
			     | IDENTIFIER NOT_EQ_OP IDENTIFIER
			     | IDENTIFIER SMALLER_OR_EQUAL IDENTIFIER
			     | IDENTIFIER GREATER_OR_EQUAL IDENTIFIER	
			     | logic_expr AND logic_expr
			     | logic_expr OR logic_expr
			     | NOT_OP LP logic_expr RP

url_expr: URL

primitive_fnc_expr: getHeat() | getHumidity() | getAirPressure() | getAirQuailty() 
						 | getLight() | getSoundLevel() | getRadiationLevel() | getTime()

term: term MULTIPLICATION_OP factor
		   | term DIVISION_OP factor
		   | term MODULO_OP factor
		   | factor

factor: number | IDENTIFIER | LP op_expr RP | IDENTIFIER LP param_list RP	

number: INT | DOUBLE | SUBSTRACTION_OP INT | SUBSTRACTION_OP DOUBLE

ident_list: IDENTIFIER | IDENTIFIER ident_list	

string: char | char string

string_expr: STRING
	
char: letter | symbol | digit

char_expr: CHAR
 
letter: 'A' | 'B' | 'C' | ... 'X' | 'Y' | 'Z' | 'a' | 'b' | 'c' | ... 'x' | 'y' | 'z'	

symbol: '!' | '"' | '#' | '$' | '%' | '&' | ''' | '( | )' | '*' | '+' | '-' | '.' | '/' | ':' | ';' | '<' | '=' | '>' | '?' | '[' | '\' | ']' | '^' | '_' | '{' | '}' | '~'	

digit: '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'			  



%%
#include "lex.yy.c"
int lineno = 0;
void yyerror(char *s) { printf("%s in line %d!\n", s, lineno); }
int main() {
    if(yynerrs < 1){
        printf("Parsing is successfully completed!\n");
    } 
    return yyparse();
}
