#include "essencial.h"
#include<string.h>
#include<stdio.h>
#include<math.h>

extern	struct Variavel variaveis[1000];
extern	unsigned int varCont;

int getVarCont(char *nome, struct Variavel *varTable, unsigned int varCnt){
    int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return i;
			}
		}
	return -1;
    }
    
extern int getTipo(char *nome, struct Variavel *varTable, unsigned int varCnt){
	int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return varTable[i].valor.tipo;
			}
		}
	return -1;
}

extern double getdbl(char *nome, struct Variavel *varTable, unsigned int varCnt){
	int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return *(varTable[i].valor.pdbl);
			}
		}
	return 0.0;
}

extern float getfl(char *nome, struct Variavel *varTable, unsigned int varCnt){
	int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return *(varTable[i].valor.pfl);
			}
		}
	return 0.0;
}

extern int getinteger(char *nome, struct Variavel *varTable, unsigned int varCnt){
	int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return *(varTable[i].valor.pint);
			}
		}
	return 0;
}

extern char* getstr(char *nome, struct Variavel *varTable, unsigned int varCnt){
	int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return *(varTable[i].valor.pstr);
			}
		}
	return(" ");
}

extern int getbool(char *nome, struct Variavel *varTable, unsigned int varCnt){
	int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return *(varTable[i].valor.pbool);
			}
		}
	return 0;
}

extern char getcaracter(char *nome, struct Variavel *varTable, unsigned int varCnt){
	int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return *(varTable[i].valor.pcaracter);
			}
		}
	return ' ';
}

extern int* getpint(char *nome, struct Variavel *varTable, unsigned int varCnt){
    int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return &(varTable[i].valor.integer);
			}
		}
	return NULL;
    }

extern char* getpchar(char *nome, struct Variavel *varTable, unsigned int varCnt){
    int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return &(varTable[i].valor.caracter);
			}
		}
	return NULL;
    }

extern char **getpstring(char *nome, struct Variavel *varTable, unsigned int varCnt){
    int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return &(varTable[i].valor.str);
			}
		}
	return NULL;
}
    

extern double* getpdouble(char *nome, struct Variavel *varTable, unsigned int varCnt){
    int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return &(varTable[i].valor.dbl);
			}
		}
	return NULL;
    }

extern float* getpfloat(char *nome, struct Variavel *varTable, unsigned int varCnt){
    int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return &(varTable[i].valor.fl);
			}
		}
	return NULL;
    }

extern int* getpbool(char *nome, struct Variavel *varTable, unsigned int varCnt){
    int i;
		for(i=0;i<varCnt;i++){
			if(strcmp(nome, varTable[i].nome)==0){
				return &(varTable[i].valor.bool);
			}
		}
	return NULL;
    }
