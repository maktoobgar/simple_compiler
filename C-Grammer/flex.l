%{
#include "y.tab.h"
void Error();
int yywrap();
%}
%%

[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ][0-9]*      {return ID;}
[0-9]+                                                            {return NUM;}
"//"[^\n]*                                                        {return COMMENT;}
"+="                                                              {return PLUSEQUAL;}
"-="                                                              {return MINESEQUAL;}
"*="                                                              {return MULTIPLYEQUAL;}
"/="                                                              {return DIVIDEEQUAL;}
"<="                                                              {return MINEQUAL;}
">="                                                              {return MAXEQUAL;}
"=="                                                              {return EQUALEQUAL;}
"!="                                                              {return NOTEQUAL;}
"-"                                                               {return MINES;}
"+"                                                               {return PLUS;}
"*"                                                               {return MULTIPLY;}
"/"                                                               {return DIVIDE;}
"%"                                                               {return DIVIDE_REMAINING;}
"<"                                                               {return MIN;}
">"                                                               {return MAX;}
"|"                                                               {return OR;}
"&"                                                               {return AND;}
"!"                                                               {return NOT;}
"="                                                               {return EQUAL;}
"("                                                               {return LEFT_PARENTHESES;}
")"                                                               {return RIGHT_PARENTHESES;}
"["                                                               {return LEFT_BRAKET;}
"]"                                                               {return RIGHT_BRAKET;}
"{"                                                               {return LEFT_BRACE;}
"}"                                                               {return RIGHT_BRACE;}
"_"                                                               {return UNDERLINE;}
","                                                               {return COMMA;}
int                                                               {return INT;}
void                                                              {return VOID;}
bool                                                              {return BOOL;}
if                                                                {return IF;}
else                                                              {return ELSE;}
return                                                            {return RETURN;}
while                                                             {return WHILE;}
break                                                             {return BREAK;}
";"                                                               {return SIMICOLON;}
true                                                              {return TRUE;}
false                                                             {return FALSE;}
[\t\n ]                                                             {;}
.                                                                 {Error(yytext);}

%%

void Error(char *ch)
{
  printf("Imported token is not accepted: ch = %s\n", ch);
}

int yywrap()
{
  return 1;
}
