#include<stdio.h>
#include<string.h>
#include "essencial.h"
#include "csharp.h"




struct Variavel variaveis[1000];
unsigned int varCont=0;
extern FILE *yyin;
extern int yyparse();

int main(int argc, char **argv){
    if(argc!=2){
                return 1;
                }
    if(!(yyin=fopen(argv[1],"r"))){
                                   return 1;
                                   }
    
    if(yyparse()==0) printf("\n\nSucesso\n");
    
    return 0;
    
}

