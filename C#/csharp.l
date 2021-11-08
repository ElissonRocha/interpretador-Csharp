%{	
	#include<stdlib.h>
	#include<string.h>
	#include<stdio.h>
	#include "essencial.h"	
	#include "csharp.h"
	
	int cont_linhas=0;
	

     int yyerror(const char*msg){
	printf("ERROR(%d): %s\n",cont_linhas, msg);
	return 1;
	}
	


%}
%option noyywrap nodefault
%x UNSAFE
%x COMENTARIO
%x COMENTARIO_DE_LINHA
%x COMENTARIO_U
%x COMENTARIO_DE_LINHA_U

%%
"unsafe:" { BEGIN( UNSAFE );}
<UNSAFE>"break;" { BEGIN(INITIAL);}
<UNSAFE>"Console.WriteLine" {return PRINT; }
<UNSAFE>"Console.Write" {return WRITE; }
<UNSAFE>"int*" {
    yylval.tipo=8;
    return TIPO;
}
<UNSAFE>"int" {	
    yylval.tipo=2;
	return TIPO; 
}
<UNSAFE>"float*" {
    yylval.tipo=7;
    return TIPO;
}
<UNSAFE>"float" {
    yylval.tipo=1;
	return TIPO; 
}
<UNSAFE>"double*" {
    yylval.tipo=6;
    return TIPO;
}
<UNSAFE>"double" {
	yylval.tipo=0;	
	return TIPO; 
}
<UNSAFE>"char*" {
    yylval.tipo=9;
    return TIPO;
}
<UNSAFE>"char" {
    yylval.tipo=3;
	return TIPO; 
}
<UNSAFE>"string*" {
    yylval.tipo=10;
    return TIPO;
}
<UNSAFE>"string" {
	yylval.tipo=4;
	return TIPO; 
}
<UNSAFE>"bool*" {
    yylval.tipo=11;
    return TIPO;
}
<UNSAFE>"bool" {
    yylval.tipo=5;
	return TIPO; 
}
<UNSAFE>"is" {	return IS; }
<UNSAFE>"as" {	return AS; }
<UNSAFE>"," { return VIRGULA; }
<UNSAFE>"&" {	return UAND; }
<UNSAFE>"^" {	return XOR; }
<UNSAFE>"|" {	return OR; }
<UNSAFE>"&&" {	return CAND; }
<UNSAFE>"||" {	return COR; }
<UNSAFE>"?" {	return COND; }
<UNSAFE>":" {	return DOISPONTOS; }
<UNSAFE>"=" {	return ATRIB;}
<UNSAFE>"+" {	return SOMA;}
<UNSAFE>"-" { 	return SUB; }
<UNSAFE>"*" { 	return UMULT; }
<UNSAFE>"/" { 	return DIV; }
<UNSAFE>"(" { 	return DPAR; }
<UNSAFE>")" { 	return EPAR; }
<UNSAFE>";" { 	return SEMICOLON; }
<UNSAFE>"==" { 	return COMP; }
<UNSAFE>"!=" {	return DIF; }
<UNSAFE>"!" {	return NOT; }
<UNSAFE>">" {	return MAIOR; }
<UNSAFE>"<" {	return MENOR; }
<UNSAFE>">=" {	return MAIGUAL;	}
<UNSAFE>"<=" {	return MEIGUAL; }
<UNSAFE>"++" {	return INCREM; }
<UNSAFE>"--" { 	return DECREM; }
<UNSAFE>"~" {	return NOTBIT; }
<UNSAFE>"%" {	return REST; }
<UNSAFE>\"(False)\" {
    yylval.valor.bool=0;
    yylval.valor.tipo=BOOL;
    return BOOLEANO;
}
<UNSAFE>\"(True)\" {
    yylval.valor.bool=1;
    yylval.valor.tipo=BOOL;
    return BOOLEANO;
}

<UNSAFE>\"(.)*\" {
    int i, j=0, tam;
    char* temp;
    tam=strlen(yytext)-2;
 	temp=(char *)malloc(tam);
    yylval.valor.tipo=STRING;
    for(i=0;i<strlen(yytext);i++){
        if(yytext[i] != '"'){
        temp[j]=yytext[i];
        j++;
    }
    temp[j]='\0';
    }
    
       yylval.valor.str=strdup(temp);
    return STR;
}

<UNSAFE>'.' {
    int i;
    yylval.valor.tipo=CHAR;
    for(i=0;i<strlen(yytext);i++){
        if(yytext[i] != '\''){
        yylval.valor.caracter=yytext[i];
    }
    }
    return CARACTER;
}
<UNSAFE>[a-zA-Z][a-zA-Z0-9]* {
	yylval.ident = strdup(yytext); 
	return VAR;
}
<UNSAFE>[0-9]+(\.[0-9]+)[Ff] {
    int i, tam;
    char* temp;
    tam = strlen(yytext) - 1;
    temp=(char *) malloc(tam);
    for(i=0;i<tam;i++){
        temp[i]=yytext[i];
    }
    temp[i]='\0';
    yylval.valor.tipo=FLOAT;
    yylval.valor.fl = atof(temp);
    return NUM_FLOAT;
}
<UNSAFE>[0-9]+(\.[0-9]+) {
   	yylval.valor.tipo = DOUBLE;
    yylval.valor.dbl = atof(yytext);
    return NUM_DOUBLE;
}
<UNSAFE>[0-9]+ {
    yylval.valor.tipo = INT;
    yylval.valor.integer = atoi(yytext);
	return NUM_INT;
}
<UNSAFE>[\t\r ] {}
<UNSAFE>"\n" { 	cont_linhas++; }
<UNSAFE>"//" { BEGIN( COMENTARIO_DE_LINHA_U ); }
<COMENTARIO_DE_LINHA_U>\n { BEGIN( UNSAFE);}
<COMENTARIO_DE_LINHA_U>. {}

<UNSAFE>"/*" { BEGIN( COMENTARIO_U);}
<COMENTARIO_U>\n { cont_linhas++;}
<COMENTARIO_U>"*/" { BEGIN( UNSAFE);}
<COMENTARIO_U>. {}

<UNSAFE>. {	char msg[64];
	sprintf(msg,"caractere ou termo invalido: %s \n", yytext);
	yyerror(msg);
	exit(7);
}

"Console.WriteLine" {return PRINT; }
"Console.Write" {return WRITE; }
"int*" {
    char msg[64];
	sprintf(msg,"Ponteiro so se utiliza dentro do unsafe!\n");
	yyerror(msg);
	exit(7);
}
"int" {	
    yylval.tipo=2;
	return TIPO; 
}
"float*" {
    char msg[64];
	sprintf(msg,"Ponteiro so se utiliza dentro do unsafe!\n");
	yyerror(msg);
	exit(7);
}
"float" {
    yylval.tipo=1;
	return TIPO; 
}
"double*" {
    char msg[64];
	sprintf(msg,"Ponteiro so se utiliza dentro do unsafe!\n");
	yyerror(msg);
	exit(7);
}
"double" {
	yylval.tipo=0;	
	return TIPO; 
}
"char*" {
    char msg[64];
	sprintf(msg,"Ponteiro so se utiliza dentro do unsafe!\n");
	yyerror(msg);
	exit(7);
}
"char" {
    yylval.tipo=3;
	return TIPO; 
}
"string*" {
    char msg[64];
	sprintf(msg,"Ponteiro so se utiliza dentro do unsafe!\n");
	yyerror(msg);
	exit(7);
}
"string" {
	yylval.tipo=4;
	return TIPO; 
}
"bool*" {
    char msg[64];
	sprintf(msg,"Ponteiro so se utiliza dentro do unsafe!\n");
	yyerror(msg);
	exit(7);
}
"bool" {
    yylval.tipo=5;
	return TIPO; 
}
"," { return VIRGULA; }
"&" {	return AND; }
"^" {	return XOR; }
"|" {	return OR; }
"&&" {	return CAND; }
"||" {	return COR; }
"?" {	return COND; }
":" {	return DOISPONTOS; }
"=" {	return ATRIB;}
"+" {	return SOMA;}
"-" { 	return SUB; }
"*" { 	return MULT; }
"/" { 	return DIV; }
"(" { 	return DPAR; }
")" { 	return EPAR; }
";" { 	return SEMICOLON; }
"==" { 	return COMP; }
"!=" {	return DIF; }
"!" {	return NOT; }
">" {	return MAIOR; }
"<" {	return MENOR; }
">=" {	return MAIGUAL;	}
"<=" {	return MEIGUAL; }
"++" {	return INCREM; }
"--" { 	return DECREM; }
"~" {	return NOTBIT; }
"%" {	return REST; }
\"(False)\" {
    printf("AKI\n");
    yylval.valor.bool=0;
    yylval.valor.tipo=BOOL;
    return BOOLEANO;
}
\"(True)\" {
    printf("AKI2");
    yylval.valor.bool=1;
    yylval.valor.tipo=BOOL;
    return BOOLEANO;
}

\"(.)*\" {
    int i, j=0, tam;
    char* temp;
    tam=strlen(yytext)-2;
 	temp=(char *)malloc(tam);
    yylval.valor.tipo=STRING;
    for(i=0;i<strlen(yytext);i++){
        if(yytext[i] != '"'){
        temp[j]=yytext[i];
        j++;
    }
    temp[j]='\0';
    }
    
       yylval.valor.str=strdup(temp);
    return STR;
}

'.' {
    int i;
    yylval.valor.tipo=CHAR;
    for(i=0;i<strlen(yytext);i++){
        if(yytext[i] != '\''){
        yylval.valor.caracter=yytext[i];
    }
    }
    return CARACTER;
}
[a-zA-Z][a-zA-Z0-9]* {
	yylval.ident = strdup(yytext); 
	return VAR;
}
[0-9]+(\.[0-9]+)[Ff] {
    int i, tam;
    char* temp;
    tam = strlen(yytext) - 1;
    temp=(char *) malloc(tam);
    for(i=0;i<tam;i++){
        temp[i]=yytext[i];
    }
    temp[i]='\0';
    yylval.valor.tipo=FLOAT;
    yylval.valor.fl = atof(temp);
    return NUM_FLOAT;
}
[0-9]+(\.[0-9]+) {
   	yylval.valor.tipo = DOUBLE;
    yylval.valor.dbl = atof(yytext);
    return NUM_DOUBLE;
}
[0-9]+ {
    yylval.valor.tipo = INT;
    yylval.valor.integer = atoi(yytext);
	return NUM_INT;
}
[\t\r ] {}
"\n" { 	cont_linhas++; }
"//" { BEGIN( COMENTARIO_DE_LINHA ); }
<COMENTARIO_DE_LINHA>\n { BEGIN( INITIAL);}
<COMENTARIO_DE_LINHA>. {}

"/*" { BEGIN( COMENTARIO);}
<COMENTARIO>\n { cont_linhas++;}
<COMENTARIO>"*/" { BEGIN( INITIAL);}
<COMENTARIO>. {}

. {	char msg[64];
	sprintf(msg,"caractere ou termo invalido: %s \n", yytext);
	yyerror(msg);
	exit(7);
}

%%

    
