%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
void yyerror (char *s);
int yylex();
%}

%start program
%token ID COMMENT PLUSEQUAL MINESEQUAL MULTIPLYEQUAL
%token DIVIDEEQUAL MINES PLUS MULTIPLY DIVIDE
%token DIVIDE_REMAINING MIN MAX MINEQUAL MAXEQUAL
%token EQUALEQUAL NOTEQUAL OR AND NOT EQUAL
%token LEFT_PARENTHESES RIGHT_PARENTHESES LEFT_BRAKET
%token RIGHT_BRAKET LEFT_BRACE RIGHT_BRACE COMMA INT
%token VOID BOOL IF RETURN SIMICOLON WHILE TRUE FALSE
%token BREAK NUM ELSE UNDERLINE
%left MINES	MINESEQUAL																	//left means left associative operator
%left PLUS PLUSEQUAL
%left DIVIDE_REMAINING
%left DIVIDE DIVIDEEQUAL
%left MULTIPLY MULTIPLYEQUAL
%right LEFT_PARENTHESES																	//right means right associative operator

%%

program:								declaration_list;
declaration_list:				declaration_list declaration
|												declaration
|												COMMENT;
declaration:						var_declaration
|												fun_declaration;
var_declaration:				type_specifier var_decl_list;
var_decl_list:					var_decl_id var_decl_list
|												ID SIMICOLON
|												ID LEFT_BRAKET NUM RIGHT_BRAKET SIMICOLON;
var_decl_id:						ID COMMA
|												ID LEFT_BRAKET NUM RIGHT_BRAKET COMMA;
type_specifier:					INT
|												VOID
|												BOOL;
fun_declaration:				type_specifier ID LEFT_PARENTHESES params LEFT_BRACE compound_stmt RIGHT_BRACE;
params:									param_list
|												RIGHT_PARENTHESES;
param_list:							param_type_list param_list
|												param_type_list RIGHT_PARENTHESES;
param_type_list:				type_specifier param_id_list;
param_id_list:					ID COMMA param_id_list
|												ID LEFT_BRAKET NUM RIGHT_BRAKET COMMA param_id_list
|												ID SIMICOLON
|												ID LEFT_BRAKET NUM RIGHT_BRAKET SIMICOLON
compound_stmt:					local_declarations statements
|												local_declarations;
local_declarations:			local_declarations var_declaration
|												;
statements:							statements statement
|												statement;
statement:							expression_stmt
|												before_selection_stmt
|												iteration_stmt
|												return_stmt
|												break_stmt;
expression_stmt:				before_expression SIMICOLON;
before_selection_stmt:	IF LEFT_PARENTHESES before_expression RIGHT_PARENTHESES statement selection_stmt;
selection_stmt:					ELSE statement
|												SIMICOLON;
iteration_stmt:					WHILE LEFT_PARENTHESES before_expression RIGHT_PARENTHESES statement;
return_stmt:						RETURN SIMICOLON
|												RETURN before_expression SIMICOLON;
break_stmt:							BREAK;
before_expression:			var expression
|												orexpression;
expression:							EQUAL expression
|												PLUSEQUAL expression
|												MINESEQUAL expression
|												orexpression;
orexpression:						simple_expression;
var:										ID LEFT_BRAKET before_expression RIGHT_BRAKET
|												ID;
simple_expression:			simple_expression OR or_expression
|												or_expression;
or_expression:					or_expression AND unary_rel_expression
|												unary_rel_expression;
unary_rel_expression:		NOT unary_rel_expression
|												rel_expression;
rel_expression:					rel_expression relop add_expression
|												add_expression;
relop:									MINEQUAL
|												MAXEQUAL
|												EQUALEQUAL
|												NOTEQUAL
|												MIN
|												MAX;
add_expression:					add_expression addop term
|												term;
addop:									PLUS
|												MINES;
term:										term mulop unary_expression
|												unary_expression;
mulop:									MULTIPLY
|												DIVIDE
|												DIVIDE_REMAINING
|												PLUSEQUAL
|												MINESEQUAL
|												MULTIPLYEQUAL
|												DIVIDEEQUAL;
unary_expression:				UNDERLINE unary_expression
|												factor;
factor:									LEFT_PARENTHESES before_expression RIGHT_PARENTHESES
|												var
|												call
|												constant;
constant:								NUM
|												TRUE
|												FALSE;
call:										ID LEFT_PARENTHESES args RIGHT_PARENTHESES;
args:										arg_list
|												;
arg_list:								arg_list COMMA before_expression
|												before_expression;


%%

int main(int argc, char *argv[])
{
	while(1)
	{
		yyparse();
	}
  return 0;
}

void yyerror (char *s)
{
	printf("parser:Syntaxerror\n");
}
