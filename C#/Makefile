all: backend.exe

lex.yy.c: lexico.l lexico.h
	.\win_flex lexico.l

sintatico.c: sintatico.y
	.\win_bison -v -d -o sintatico.c sintatico.y

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

sintatico.o: sintatico.c
	gcc -c sintatico.c

main.o: main.c
	gcc -c main.c

compilador.exe: main.o sintatico.o lex.yy.o
	gcc main.o compilador.o lex.yy.o -o compilador.exe