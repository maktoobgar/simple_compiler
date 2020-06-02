%{
void yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
int symbols[52];
int symbolVal(char id);
void updateSymbolVal(char id, int val);
%}

%union {int num; char id;}
%start stmtloop
%token print
%token exit_command
%token get_command
%token int_command
%token <num> number
%token <id> identifier
%type <num> exp
%type <id> assign
%left '-'
%left '+'
%left '/'
%left '*'

%%

stmtloop:     stmtloop stmt                         {;}
|             stmt                                  {;};
stmt:         exp dot                               {;}
|             print exp dot                         {printf("%d\n", $2);}
|             assign dot                            {;}
|             exit_command dot                      {exit(EXIT_SUCCESS);};
exp:          exp '+' exp                           {$$ = ($1 + $3); printf(" -------\n avali: %d \n + \n dovomi: %d \n hasel: %d\n -------\n", $1, $3, ($1 + $3));}
|             exp '-' exp                           {$$ = ($1 - $3); printf(" -------\n avali: %d \n - \n dovomi: %d \n hasel: %d\n -------\n", $1, $3, ($1 - $3));}
|             exp '/' exp                           {$$ = ($1 / $3); printf(" -------\n avali: %d \n / \n dovomi: %d \n hasel: %d\n -------\n", $1, $3, ($1 / $3));}
|             exp '*' exp                           {$$ = ($1 * $3); printf(" -------\n avali: %d \n * \n dovomi: %d \n hasel: %d\n -------\n", $1, $3, ($1 * $3));}
|             number                                {$$ = $1;}
|             identifier                            {$$ = symbolVal($1);}
|             get_command                           {char str1[20]; scanf("%s", str1); $$ = atoi(str1);};
assign:       identifier '=' exp                    {updateSymbolVal($1, $3);}
|             int_command identifier '=' exp        {updateSymbolVal($2, $4);};
dot:          ';'                                   {;};

%%

int computeSymbolIndex(char id)
{
	int idx = -1;
	if(islower(id)) {
		idx = id - 'a' + 26;
	} else if(isupper(id)) {
		idx = id - 'A';
	}
	return idx;
}

int symbolVal(char id)
{
	int index = computeSymbolIndex(id);
	return symbols[index];
}

void updateSymbolVal(char id, int val)
{
	int bucket = computeSymbolIndex(id);
	symbols[bucket] = val;
}

int main(void)
{
	int i;
	for(i = 0; i < 52; i++)
  {
		symbols[i] = 0;
	}
	return yyparse ();
  return 0;
}

void yyerror (char *s)
{

}
