#include<string.h>
#include<stdio.h>
#include<math.h>
#ifndef _essencial_h
#define _essencial_h

enum Tipo{
	DOUBLE,
	FLOAT,
	INT,
	CHAR,
	STRING,
	BOOL,
	PDOUBLE,
	PFLOAT,
	PINT,
	PCHAR,
	PSTRING,
	PBOOL
};

struct Valor{
		union {
			double dbl;
			float fl;
			int integer;
			char caracter;
			char* str;
			int bool;
			int *pint;
			char *pcaracter;
			double *pdbl;
			float *pfl;
			int *pbool;
			char** pstr;
			};
		
		enum Tipo tipo;	
};


struct Variavel{
		char* nome;
		struct Valor valor;	
		};

struct Nomes{
        char* nome[256];
        int tamanho;
        struct Valor Vn[256];
};

int getVarCont(char *nome, struct Variavel *varTable, unsigned int varCnt);    
int getTipo(char *nome, struct Variavel *varTable, unsigned int varCnt);
double getdbl(char *nome, struct Variavel *varTable, unsigned int varCnt);
float getfl(char *nome, struct Variavel *varTable, unsigned int varCnt);
int getinteger(char *nome, struct Variavel *varTable, unsigned int varCnt);
char* getstr(char *nome, struct Variavel *varTable, unsigned int varCnt);
int getbool(char *nome, struct Variavel *varTable, unsigned int varCnt);
char getcaracter(char *nome, struct Variavel *varTable, unsigned int varCnt);
int* getpint(char *nome, struct Variavel *varTable, unsigned int varCnt);
char* getpchar(char *nome, struct Variavel *varTable, unsigned int varCnt);
char **getpstring(char *nome, struct Variavel *varTable, unsigned int varCnt);
double* getpdouble(char *nome, struct Variavel *varTable, unsigned int varCnt);
float* getpfloat(char *nome, struct Variavel *varTable, unsigned int varCnt);
int* getpbool(char *nome, struct Variavel *varTable, unsigned int varCnt);

#endif
