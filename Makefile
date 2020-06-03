lex.yy.c: flex.l
	lex flex.l

y.tab.c and y.tab.h:
	yacc conf.y -d

a.out: lex.yy.c y.tab.c y.tab.h
	gcc lex.yy.c y.tab.c
