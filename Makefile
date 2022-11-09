parser: lex.yy.c y.tab.c
	gcc -o parser y.tab.c
y.tab.c: CS315f22_team32.y
	yacc CS315f22_team32.y
lex.yy.c: CS315f22_team32.l
	lex CS315f22_team32.l
clean:
	rm -f lex.yy.c y.tab.c parser
