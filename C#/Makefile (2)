all: compilador.exe

FuncoesE.o: FuncoesE.c
	gcc -c FuncoesE.c

lex.yy.c: compilador.l compilador.h
	.\win_flex compilador.l

compilador.c: compilador.y
	.\win_bison -v -d -o compilador.c compilador.y

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

compilador.o: compilador.c
	gcc -c compilador.c

main.o: main.c
	gcc -c main.c

compilador.exe: main.o compilador.o lex.yy.o FuncoesE.o
	gcc main.o compilador.o lex.yy.o FuncoesE.o -o compilador.exe