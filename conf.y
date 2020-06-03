%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
void yyerror (char *s);
int yylex();
int idenValue(char id);
void updateIdenVal(char id, int val);
int idens[52];
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
exp:          exp '+' exp                           {$$ = ($1 + $3); }
|             exp '-' exp                           {$$ = ($1 - $3); }
|             exp '/' exp                           {$$ = ($1 / $3); }
|             exp '*' exp                           {$$ = ($1 * $3); }
|             number                                {$$ = $1;}
|             identifier                            {$$ = idenValue($1);}
|             get_command                           {char str1[20]; scanf("%s", str1); $$ = atoi(str1);};
assign:       identifier '=' exp                    {updateIdenVal($1, $3);}
|             int_command identifier '=' exp        {updateIdenVal($2, $4);};
dot:          ';'                                   {;};

%%

int indenIndex(char id)
{
	int idx = -1;
	if(islower(id)) {
		idx = id - 'a' + 26;
	} else if(isupper(id)) {
		idx = id - 'A';
	}
	return idx;
}

int idenValue(char id)
{
	int index = indenIndex(id);
	return idens[index];
}

void updateIdenVal(char id, int val)
{
	int index = indenIndex(id);
	idens[index] = val;
}

int main(void)
{
	int i;
	for(i = 0; i < 52; i++)
  {
		idens[i] = 0;
	}
	return yyparse ();
  return 0;
}

void yyerror (char *s)
{
	printf("parser:Syntaxerror\n");
	yyparse();
}
