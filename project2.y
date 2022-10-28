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
      | comment_stmt
      | fnc_stmt
      | connect_stmt
      | send_stmt
      | receive_stmt
      | print_stmt
      | input_stmt
if_stmt: // continue from here
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
