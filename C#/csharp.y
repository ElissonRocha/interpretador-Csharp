%{
    #include "essencial.h"
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	#include<string.h>

	extern  int yyerror(const char *msg);
	extern int yylex();
	extern	struct Variavel variaveis[1000];
	extern	unsigned int varCont;
    
%}

%token BREAK
%token TIPO
%token VAR
%token ATRIB
%token PRINT
%token WRITE
%token STR
%token CARACTER
%token BOOLEANO
%token NUM_INT
%token NUM_FLOAT
%token NUM_DOUBLE
%token SOMA
%token SUB
%token DIV
%token MULT
%token UMULT
%token EPAR
%token DPAR
%token SEMICOLON
%token COMP
%token DIF
%token NOT
%token MAIOR
%token MENOR
%token MAIGUAL
%token MEIGUAL
%token INCREM
%token DECREM
%token NOTBIT
%token REST
%token IS
%token AS
%token UAND
%token AND
%token XOR
%token OR
%token CAND
%token COR
%token CNULA
%token COND
%token DOISPONTOS
%token VIRGULA


%union{
	char* ident;
	int tipo;
	struct Valor valor;
	struct Nomes nnomes;
};

%type <tipo> TIPO
%type <valor> STR
%type <valor> CARACTER
%type <valor> BOOLEANO
%type <valor> NUM_INT
%type <valor> NUM_DOUBLE
%type <valor> NUM_FLOAT
%type <valor> Expressao
%type <valor> ExpressaoBin
%type <valor> Fator
%type <valor> termo
%type <ident> VAR
%type <nnomes> NVAR

%%

programa:
	comandos;

comandos:
	comando
	|comandos comando;

comando: 
	Atribuicao
	|Write
	|Print
	|DeclaracaoDeVariavel
    ;

Write:
	WRITE DPAR Expressao EPAR SEMICOLON{
		if(($3).tipo==BOOL){
        	if(($3).bool == 0){
            	printf("False");
        	}
        	else printf("TRUE");
    	}   
        else if(($3).tipo==CHAR){
            printf("%c",($3).caracter);
            break;
        }
        else if(($3).tipo==INT){
            printf("%d",($3).integer);
        }
        else if(($3).tipo==FLOAT){
            printf("%.2f",($3).fl);
        }
        else if(($3).tipo==DOUBLE){
            printf("%lf",($3).dbl);
        }
        else if(($3).tipo==STRING){
            printf("%s",($3).str);
            break;
        }
        if(($3).tipo==PBOOL){
            printf("%d",($3).pbool);
    	}   
        else if(($3).tipo==PCHAR){
            printf("%c",($3).caracter);
            break;
        }
        else if(($3).tipo==PINT){
            printf("%d",($3).pint);
        }
        else if(($3).tipo==PFLOAT){
            printf("%.2f",($3).pfl);
        }
        else if(($3).tipo==PDOUBLE){
            printf("%lf",($3).pdbl);
        }
        else if(($3).tipo==PSTRING){
            printf("%s",($3).pstr);
            break;
        }
        }

Print:
    PRINT DPAR Expressao EPAR SEMICOLON{
        if(($3).tipo==BOOL){
        	if(($3).bool == 0){
            	printf("FALSE\n");
        	}
        	else printf("TRUE\n");
    	}   
        else if(($3).tipo==CHAR){
            printf("%c\n",($3).caracter);
            break;
        }
        else if(($3).tipo==INT){
            printf("%d\n",($3).integer);
        }
        else if(($3).tipo==FLOAT){
            printf("%.2f\n",($3).fl);
        }
        else if(($3).tipo==DOUBLE){
            printf("%lf\n",($3).dbl);
        }
        else if(($3).tipo==STRING){
            printf("%s\n",($3).str);
            break;
        }
        if(($3).tipo==PBOOL){
            printf("%d\n",($3).pbool);
    	}   
        else if(($3).tipo==PCHAR){
            printf("%c\n",($3).caracter);
            break;
        }
        else if(($3).tipo==PINT){
            printf("%d\n",($3).pint);
        }
        else if(($3).tipo==PFLOAT){
            printf("%.2f\n",($3).pfl);
        }
        else if(($3).tipo==PDOUBLE){
            printf("%lf\n",($3).pdbl);
        }
        else if(($3).tipo==PSTRING){
            printf("%s\n",($3).pstr);
            break;
        }
        }
        
DeclaracaoDeVariavel:
        TIPO NVAR SEMICOLON{
            int i, j, achou=0;
            for(j=0;j<($2).tamanho;j++){
                    for(i=0;i<varCont;i++){
			             if(strcmp(variaveis[i].nome,($2).nome[j])==0){
				                char msg[200];
                				sprintf(msg, " A variavel %s ja foi declarada\n", $2);
                				yyerror(msg);
                				achou=1;
                                exit(1);
                				break;
                			}
                		}
                    	if(!achou){ 
                    		variaveis[varCont].nome=($2).nome[j];
                            if(($2).Vn[j].tipo!=15){
                                if(($1)==($2).Vn[j].tipo){
                                      variaveis[varCont].valor=($2).Vn[j];
                                }
                                else{
                                    char msg[200];
                    				sprintf(msg, " Tipo de Expressao difere do tipo declarado\n", $2);
                    				yyerror(msg);
                    				achou=1;
                                    exit(1);
                    				break;
                                }
                            }
                            else variaveis[varCont].valor.tipo=($1);
                            
                            varCont++;
                    	}            
                }
            
            }
        ;

NVAR:
    
    VAR{
        struct Nomes n;
        n.nome[0]=$1;
        n.Vn[0].tipo=15;
        n.tamanho=1;
        $$=n;
    }
    |VAR ATRIB Expressao{
        struct Nomes n;
        n.nome[0]=$1;
        n.Vn[0].tipo=($3).tipo;
        if(n.Vn[0].tipo==INT){
            n.Vn[0].integer=($3).integer;
        }
        else if(n.Vn[0].tipo==CHAR){
            n.Vn[0].caracter=($3).caracter;
        }
        else if(n.Vn[0].tipo==STRING){
            n.Vn[0].str=($3).str;
        }
        else if(n.Vn[0].tipo==BOOL){
            n.Vn[0].bool=($3).bool;
        }
        else if(n.Vn[0].tipo==DOUBLE){
            n.Vn[0].dbl=($3).dbl;
        }
        else if(n.Vn[0].tipo==FLOAT){
            n.Vn[0].fl=($3).fl;
        }
        else if(n.Vn[0].tipo==PINT){
            n.Vn[0].pint=($3).pint;
        }
        else if(n.Vn[0].tipo==PDOUBLE){
            n.Vn[0].pdbl=($3).pdbl;
        }
        else if(n.Vn[0].tipo==PFLOAT){
            n.Vn[0].pfl=($3).pfl;
        }
        else if(n.Vn[0].tipo==PCHAR){
            n.Vn[0].pcaracter=($3).pcaracter;
        }
        else if(n.Vn[0].tipo==PSTRING){
            n.Vn[0].pstr=($3).pstr;
        }
        else if(n.Vn[0].tipo==PBOOL){
            n.Vn[0].pbool=($3).pbool;
        }
        
        n.tamanho=1;
        $$=n;
    }
    |NVAR VIRGULA VAR{
        int i;
        struct Nomes n;
        if(n.tamanho==0){
            n.nome[1]=$3;
            n.Vn[1].tipo=15;
            n.tamanho++;
        }
        else{
            for(i=n.tamanho;i>1;i--){
                n.nome[i]=n.nome[i-1];
                n.Vn[i]=n.Vn[i-1];
            }
            n.nome[1]=$3;
            n.Vn[1].tipo=15;
            n.tamanho++;
        }
        $$=n;
    }
    |NVAR VIRGULA VAR ATRIB Expressao{
        int i;
        struct Nomes n;
        if(n.tamanho==0){
            n.nome[1]=$3;
            n.Vn[1].tipo=($5).tipo;
            if(n.Vn[1].tipo==INT){
                n.Vn[1].integer=($5).integer;
            }
            else if(n.Vn[1].tipo==CHAR){
                n.Vn[1].caracter=($5).caracter;
            }
            else if(n.Vn[1].tipo==STRING){
                n.Vn[1].str=($5).str;
            }
            else if(n.Vn[1].tipo==BOOL){
                n.Vn[1].bool=($5).bool;
            }
            else if(n.Vn[1].tipo==DOUBLE){
                n.Vn[1].dbl=($5).dbl;
            }
            else if(n.Vn[1].tipo==FLOAT){
                n.Vn[1].fl=($5).fl;
            }
            else if(n.Vn[0].tipo==PINT){
                n.Vn[1].pint=($5).pint;
            }
            else if(n.Vn[0].tipo==PDOUBLE){
                n.Vn[1].pdbl=($5).pdbl;
            }
            else if(n.Vn[0].tipo==PFLOAT){
                n.Vn[1].pfl=($5).pfl;
            }
            else if(n.Vn[0].tipo==PCHAR){
                n.Vn[1].pcaracter=($5).pcaracter;
            }
            else if(n.Vn[0].tipo==PSTRING){
                n.Vn[1].pstr=($5).pstr;
            }
            else if(n.Vn[0].tipo==PBOOL){
                n.Vn[1].pbool=($5).pbool;
            }
                n.tamanho++;
        }
        else{
            for(i=n.tamanho;i>1;i--){
                n.nome[i]=n.nome[i-1];
                n.Vn[i]=n.Vn[i-1];
            }
            n.nome[1]=$3;
            n.Vn[1].tipo=($5).tipo;
            if(n.Vn[1].tipo==INT){
                n.Vn[1].integer=($5).integer;
            }
            else if(n.Vn[1].tipo==CHAR){
                n.Vn[1].caracter=($5).caracter;
            }
            else if(n.Vn[1].tipo==STRING){
                n.Vn[1].str=($5).str;
            }
            else if(n.Vn[1].tipo==BOOL){
                n.Vn[1].bool=($5).bool;
            }
            else if(n.Vn[1].tipo==DOUBLE){
                n.Vn[1].dbl=($5).dbl;
            }
            else if(n.Vn[1].tipo==FLOAT){
                n.Vn[1].fl=($5).fl;
            }
            else if(n.Vn[0].tipo==PINT){
                n.Vn[1].pint=($5).pint;
            }
            else if(n.Vn[0].tipo==PDOUBLE){
                n.Vn[1].pdbl=($5).pdbl;
            }
            else if(n.Vn[0].tipo==PFLOAT){
                n.Vn[1].pfl=($5).pfl;
            }
            else if(n.Vn[0].tipo==PCHAR){
                n.Vn[1].pcaracter=($5).pcaracter;
            }
            else if(n.Vn[0].tipo==PSTRING){
                n.Vn[1].pstr=($5).pstr;
            }
            else if(n.Vn[0].tipo==PBOOL){
                n.Vn[1].pbool=($5).pbool;
            }
            n.tamanho++;
        }
        $$=n;
    }
    ;    
        
Atribuicao:
	VAR ATRIB Expressao SEMICOLON {
	int i=0, achou=0;
		for(i=0;i<varCont;i++){
			if(strcmp(variaveis[i].nome,$1)==0){
                 if(variaveis[i].valor.tipo==($3).tipo){
                    variaveis[i].valor=($3);
				    achou=1;
			 	   break;
			}
		}
    }
    if(!achou){
				char msg[200];
				sprintf(msg, " A variavel %s nao foi declarada\n", $1);
				yyerror(msg);
				exit(2);
                break;
		}
}
    
    |INCREM VAR SEMICOLON{
        int i, achou=0;
		for(i=0;i<varCont;i++){
            if(strcmp(variaveis[i].nome,$2)==0){
                if(variaveis[i].valor.tipo==INT){
            	variaveis[i].valor.integer = (variaveis[i].valor.integer + 1);
			    achou=1;
				break;
                }
                else {
                    char msg[200];
			         sprintf(msg, " Tipo incompativel\n", $2);
			         yyerror(msg);
                        exit(3);
                    }
			}
		}
		if(achou==0){
			char msg[200];
			sprintf(msg, " A variavel %s nao foi declarada\n", $2);
			yyerror(msg);
			exit(2);
			
		}
	}
	|DECREM VAR SEMICOLON{
        int i, achou=0;
		for(i=0;i<varCont;i++){
            if(strcmp(variaveis[i].nome,$2)==0){
                if(variaveis[i].valor.tipo==INT){
                variaveis[i].valor.integer = (variaveis[i].valor.integer - 1);
				achou=1;
				break;
                }
                else {
                    char msg[200];
			         sprintf(msg, " Tipo incompativel\n", $2);
			         yyerror(msg);
                    exit(3);
                    }
			}
		}
		if(achou==0){
			char msg[200];
			sprintf(msg, " A variavel %s nao foi declarada\n", $2);
			yyerror(msg);
			exit(2);
			
		}
	}
	|UMULT VAR ATRIB Expressao SEMICOLON{
        struct Valor v;
        int tipo, lugar;
        lugar=getVarCont($2, variaveis, varCont);
        tipo=getTipo($2, variaveis, varCont);
        switch(tipo){
            case DOUBLE:
            case INT:
            case FLOAT:
            case STRING:
            case BOOL:
            case CHAR:
                {
                char msg[200];
    			sprintf(msg, " a variavel %s nao eh ponteiro\n", $2);
    	   		yyerror(msg);
    			exit(7);
    		    break;
                }
    		case PINT:
			    if(($4).tipo==INT){v=$4;}
                break;
            case PCHAR:
                if(($4).tipo==CHAR){v=$4;}
                break;
            case PSTRING:
                if(($4).tipo==STRING){v=$4;}
                break;
			case PDOUBLE:
                if(($4).tipo==DOUBLE){v=$4;}
                break;
			case PFLOAT:
                if(($4).tipo==FLOAT){v=$4;}
			    break;
			case PBOOL:
                if(($4).tipo==BOOL){v=$4;}
                break;
            default: {
                char msg[200];
    			sprintf(msg, " Declare a Variavel\n");
    	   		yyerror(msg);
    			exit(7);
    		    break;
            }
            }
        variaveis[lugar].valor=v;
       }
    |UAND VAR ATRIB Expressao SEMICOLON {
        struct Valor v;
        int tipo, lugar;
        lugar=getVarCont($2,variaveis, varCont);
        tipo=getTipo($2, variaveis, varCont);
        switch(tipo){
            case PINT:
            case PCHAR:
            case PSTRING:
            case PDOUBLE:
            case PFLOAT:
            case PBOOL:
                {
                char msg[200];
    			sprintf(msg, " a variavel %s ja guarda o local da memoria\n", $2);
    	   		yyerror(msg);
    			exit(7);
    		    break;
                }
    		case INT:
                if(($4).tipo=PINT){v=$4;}
                break;
            case CHAR:
                if(($4).tipo==PCHAR){v=$4;}
                break;
            case STRING:
                if(($4).tipo==PSTRING){v=$4;}
                break;
            case DOUBLE:
                if(($4).tipo==PDOUBLE){v=$4;}
                break;
            case FLOAT:
                if(($4).tipo==PFLOAT){v=$4;}
                break;
            case BOOL:
                if(($4).tipo==PBOOL){v=$4;}
                break;
            default:
                {
                char msg[200];
    			sprintf(msg, " Declare a Variavel\n");
    	   		yyerror(msg);
    			exit(7);
    		    break;
            }
            }
        variaveis[lugar].valor=v;
        }
;

Expressao:
	Fator {$$=$1;}
	|ExpressaoBin{$$=$1;}
    ;

ExpressaoBin:
	Expressao COMP Fator{
			struct Valor val;
				if(($1).tipo==BOOL && ($3).tipo==BOOL){
				    if(($1).bool==($3).bool){
                    	val.bool=1;
					}
					else {
                    	val.bool=0;
					}
					
				}				
				else if(($1).tipo==STRING && ($3).tipo==STRING){
                    if(strcmp(($1).str,($3).str)==0){
                    	val.bool=1;
					}
					else {
                        val.bool=0;
                    }

				
				}
				else if(($1).tipo==CHAR && ($3).tipo==CHAR){
					if(($1).caracter==($3).caracter){
						val.bool=1;
					}
					else val.bool=0;

				
				}
				else if(($1).tipo==DOUBLE && ($3).tipo==DOUBLE){
					if(($1).dbl==($3).dbl){
						val.bool=1;
					}
					else val.bool=0;

				
				}				
				else if(($1).tipo==FLOAT && ($3).tipo==FLOAT){
					if(($1).fl==($3).fl){
						val.bool=1;
					}
					else val.bool=0;

				
				}
				else if(($1).tipo==INT && ($3).tipo==INT){
					if(($1).integer==($3).integer){
                    	val.bool=1;
					}
					else val.bool=0;
				
				}
				else {
                    yyerror("Tipo errado");
                    exit(4);
                }
				val.tipo=BOOL;
				$$=val;	
	}
	| Expressao DIF Fator{
			struct Valor val;
				if(($1).tipo==BOOL && ($3).tipo==BOOL){
					if(($1).bool!=($3).bool){
						val.bool=1;
					}
					else {
						val.bool=0;
					}
					
				}				
				else if(($1).tipo==STRING && ($3).tipo==STRING){
					if(strcmp(($1).str,($3).str)!=0){
						val.bool=1;
					}
					else val.bool=0;
					
				}
				else if(($1).tipo==CHAR && ($3).tipo==CHAR){
					if(($1).caracter!=($3).caracter){
						val.bool=1;
					}
					else val.bool=0;
					
				}
				else if(($1).tipo==DOUBLE && ($3).tipo==DOUBLE){
					if(($1).dbl!=($3).dbl){
						val.bool=1;
					}
					else val.bool=0;
				}				
				else if(($1).tipo==FLOAT && ($3).tipo==FLOAT){
					if(($1).fl!=($3).fl){
						val.bool=1;
					}
					else val.bool=0;
				}
				else if(($1).tipo==INT && ($3).tipo==INT){
					if(($1).integer!=($3).integer){
						val.bool=1;
					}
					else val.bool=0;
				}
				else {
                    yyerror("Tipo errado");
                    exit(4);
                }
                val.tipo=BOOL;
				

				$$=val;			
	} 
	|Expressao MAIOR Fator{
                struct Valor val;
					if((($1).tipo==BOOL || ($1).tipo==STRING) || (($3).tipo==BOOL || ($3).tipo==STRING)){
								char msg[200];
					           sprintf(msg, "Tipo incompativel\n");
					           yyerror(msg);
					           exit(4);     
					           break;
					}
					else if(($1).tipo==CHAR){
                        if(($1).caracter > (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==INT){
                        if(($1).integer > (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==FLOAT){
                        if(($1).fl > (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==DOUBLE){
                        if(($1).dbl > (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    val.tipo=BOOL;
                    $$=val;
	}
	|Expressao MENOR Fator{
				struct Valor val;
					if((($1).tipo==BOOL || ($1).tipo==STRING) || (($3).tipo==BOOL || ($3).tipo==STRING)){
								char msg[200];
					           sprintf(msg, "Tipo incompativel\n");
					           yyerror(msg);
					           exit(4);     
					           break;
					}
					else if(($1).tipo==CHAR){
                        if(($1).caracter < (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==INT){
                        if(($1).integer < (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==FLOAT){
                        if(($1).fl < (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==DOUBLE){
                        if(($1).dbl < (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    val.tipo=BOOL;
                    $$=val;
    }
    |Expressao MAIGUAL Fator{
				struct Valor val;
					if((($1).tipo==BOOL || ($1).tipo==STRING) || (($3).tipo==BOOL || ($3).tipo==STRING)){
								char msg[200];
					           sprintf(msg, "Tipo incompativel\n");
					           yyerror(msg);
					           exit(4);     
					           break;
					}
					else if(($1).tipo==CHAR){
                        if(($1).caracter >= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==INT){
                        if(($1).integer >= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==FLOAT){
                        if(($1).fl >= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==DOUBLE){
                        if(($1).dbl >= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    val.tipo=BOOL;
                    $$=val;
    }
    |Expressao MEIGUAL Fator{
				struct Valor val;
					if((($1).tipo==BOOL || ($1).tipo==STRING) || (($3).tipo==BOOL || ($3).tipo==STRING)){
								char msg[200];
					           sprintf(msg, "Tipo incompativel\n");
					           yyerror(msg);
					           exit(4);     
					           break;
					}
					else if(($1).tipo==CHAR){
                        if(($1).caracter <= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==INT){
                        if(($1).integer <= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==FLOAT){
                        if(($1).fl <= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    else if(($1).tipo==DOUBLE){
                        if(($1).dbl <= (($3).tipo==CHAR?($3).caracter:(($3).tipo==INT?($3).integer:(($3).tipo==FLOAT?($3).fl:($3).dbl)))){
                            val.bool=1;
                        }else val.bool=0;
                    
                    }
                    val.tipo=BOOL;
                    $$=val;
    }
    
	|Expressao AND Fator{
                       struct Valor val;
                       if(($1).tipo==BOOL && ($3).tipo==BOOL){
                            val.bool=(($1).bool)*(($3).bool);
                            val.tipo=BOOL;
                        }
                        else{
                               char msg[200];
					           sprintf(msg, "Tipo incompativel\n");
					           yyerror(msg);
                                exit(4);
                        }
                        $$=val; 
    }
    
    |Expressao UAND Fator{
                       struct Valor val;
                       if(($1).tipo==BOOL && ($3).tipo==BOOL){
                            val.bool=(($1).bool)*(($3).bool);
                            val.tipo=BOOL;
                        }
                        else{
                               char msg[200];
					           sprintf(msg, "Tipo incompativel\n");
					           yyerror(msg);
                                exit(4);
                        }
                        $$=val; 
    }
    
    |Expressao OR Fator{
                        struct Valor val;
                       if(($1).tipo==BOOL && ($3).tipo==BOOL){
                            val.bool=((($1).bool)+(($3).bool));
                            val.tipo=BOOL;
                        }
                        else{
                               char msg[200];
					           sprintf(msg, "Tipo incompativel\n");
					           yyerror(msg);
                                exit(4);
                        }
                        $$=val; 
    }
    
    |Expressao XOR Fator{
                        struct Valor val;
                       if(($1).tipo==BOOL && ($3).tipo==BOOL){
                            if(($1).bool==1 && ($3).bool==1){
                                val.bool=0;
                                val.tipo=BOOL;
                            }
                            else {
                            val.bool=(($1).bool)+(($3).bool);
                            val.tipo=BOOL;
                            }
                        }
                        else{
                               char msg[200];
					           sprintf(msg, "Tipo BOOL incompativel\n");
					           yyerror(msg);
					           exit(4);       
                        }
                        $$=val; 
    }
    |Expressao COMP TIPO{
                struct Valor val;
                    if(($1).tipo==($3)){
                        val.bool=1;
                        }
                    else {
                        val.bool=0;
                }
                    val.tipo=BOOL;
                    $$=val;
    }
	
    |Expressao SOMA Fator{
				struct Valor val;
				if(($1).tipo==STRING && ($3).tipo==STRING ){
					char* res;
					int tam=strlen(($1).str)+strlen(($3).str)+1;
					res=(char*)malloc(tam);
					strcpy(res,($1).str);
					strcat(res,($3).str);
					val.str=res;
					val.tipo=STRING;
					}
				else if(($1).tipo==STRING){
					char* res;
					char conc[20];
					int tam=strlen(($1).str)+20;
					res=(char*)malloc(tam);
						if(($3).tipo==INT){
							sprintf(res, "%s%i",($1).str, ($3).integer);
							val.str=res;
							val.tipo=STRING;
							}
						if(($3).tipo==DOUBLE){
							sprintf(res, "%s%lf",($1).str, ($3).dbl);
							val.str=res;
							val.tipo=STRING;
							}
						if(($3).tipo==BOOL){
							sprintf(res, "%s%s",($1).str, ($3).bool?"true":"false");
							val.str=res;
							val.tipo=STRING;
							}
						if(($3).tipo==FLOAT){
							sprintf(res, "%s%f",($1).str, ($3).fl);
							val.str=res;
							val.tipo=STRING;
							}
						if(($3).tipo==CHAR){
							sprintf(res, "%s%c",($1).str, ($3).caracter);
							val.str=res;
							val.tipo=STRING;
							}
					}
				else if(($1).tipo==BOOL || ($3).tipo==BOOL){
					char msg[200];
					sprintf(msg, "Tipo BOOL incompativel\n");
					yyerror(msg);
					
					break;
				}
				else if(($1).tipo==DOUBLE || ($3).tipo==DOUBLE){
					val.dbl=(($1).tipo==DOUBLE?($1).dbl:(($1).tipo==FLOAT?($1).fl:($1).integer)) + (($3).tipo==DOUBLE?($3).dbl:(($3).tipo==FLOAT?($3).fl:($3).integer));
					val.tipo=DOUBLE;
				}				
				else if(($1).tipo==FLOAT || ($3).tipo==FLOAT){
					val.fl=(($1).tipo==FLOAT?($1).fl:($1).integer) + (($3).tipo==FLOAT?($3).fl:($3).integer);
					val.tipo=FLOAT;
				}
				else if(($1).tipo==INT || ($3).tipo==INT){
                    val.integer=($1).integer + ($3).integer;
					val.tipo=INT;
				}
				else {
                    yyerror("Tipo errado");
                    exit(4);
                }
                    	$$=val;				
	}

	|Expressao SUB Fator{
			struct Valor val;
				if(($1).tipo==BOOL || ($3).tipo==BOOL){
					char msg[200];
					sprintf(msg, "Tipo BOOL incompativel\n");
					yyerror(msg);
					exit(4);
					break;
				}				
				else if((($1).tipo==STRING || ($3).tipo==STRING) || (($1).tipo==CHAR || ($3).tipo==CHAR)){
					char msg[200];
					sprintf(msg, " Tipo STRING/CHAR incompativel\n");
					yyerror(msg);
					exit(4);
					break;
				}
				else if(($1).tipo==DOUBLE || ($3).tipo==DOUBLE){
					val.dbl=(($1).tipo==DOUBLE?($1).dbl:(($1).tipo==FLOAT?($1).fl:($1).integer)) - (($3).tipo==DOUBLE?($3).dbl:(($3).tipo==FLOAT?($3).fl:($3).integer));
					val.tipo=DOUBLE;
				}				
				else if(($1).tipo==FLOAT || ($3).tipo==FLOAT){
					val.fl=(($1).tipo==FLOAT?($1).fl:($1).integer) - (($3).tipo==FLOAT?($3).fl:($3).integer);
					val.tipo=FLOAT;
				}
				else if(($1).tipo==INT || ($3).tipo==INT){
					val.integer=($1).integer - ($3).integer;
					val.tipo=INT;
				}
				$$=val;
	}
	|NOT Fator{
            struct Valor val;
                    if(($2).tipo==BOOL){
                        val.bool=!(($2).bool);
                 }
                 else {
                    char msg[200];
					sprintf(msg, " Tipo incompativel\n");
					yyerror(msg);
					exit(4);
                    }
                 val.tipo=BOOL;
                 $$=val;
    }
	;

Fator:
	Fator MULT termo{
			struct Valor val;
				if(($1).tipo==BOOL || ($3).tipo==BOOL){
					char msg[200];
					sprintf(msg, "Tipo BOOL incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}				
				else if((($1).tipo==STRING || ($3).tipo==STRING) || (($1).tipo==CHAR || ($3).tipo==CHAR)){
					char msg[200];
					sprintf(msg, " Tipo STRING/CHAR incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}
				else if(($1).tipo==DOUBLE || ($3).tipo==DOUBLE){
					val.dbl=(($1).tipo==DOUBLE?($1).dbl:(($1).tipo==FLOAT?($1).fl:($1).integer)) * (($3).tipo==DOUBLE?($3).dbl:(($3).tipo==FLOAT?($3).fl:($3).integer));
					val.tipo=DOUBLE;
				}				
				else if(($1).tipo==FLOAT || ($3).tipo==FLOAT){
					val.fl=(($1).tipo==FLOAT?($1).fl:($1).integer) * (($3).tipo==FLOAT?($3).fl:($3).integer);
					val.tipo=FLOAT;
				}
				else if(($1).tipo==INT || ($3).tipo==INT){
					val.fl=($1).integer * ($3).integer;
					val.tipo=INT;
				}
				$$=val;
}
    |Fator UMULT termo{
			struct Valor val;
				if(($1).tipo==BOOL || ($3).tipo==BOOL){
					char msg[200];
					sprintf(msg, "Tipo BOOL incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}				
				else if((($1).tipo==STRING || ($3).tipo==STRING) || (($1).tipo==CHAR || ($3).tipo==CHAR)){
					char msg[200];
					sprintf(msg, " Tipo STRING/CHAR incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}
				else if(($1).tipo==DOUBLE || ($3).tipo==DOUBLE){
					val.dbl=(($1).tipo==DOUBLE?($1).dbl:(($1).tipo==FLOAT?($1).fl:($1).integer)) * (($3).tipo==DOUBLE?($3).dbl:(($3).tipo==FLOAT?($3).fl:($3).integer));
					val.tipo=DOUBLE;
				}				
				else if(($1).tipo==FLOAT || ($3).tipo==FLOAT){
					val.fl=(($1).tipo==FLOAT?($1).fl:($1).integer) * (($3).tipo==FLOAT?($3).fl:($3).integer);
					val.tipo=FLOAT;
				}
				else if(($1).tipo==INT || ($3).tipo==INT){
					val.fl=($1).integer * ($3).integer;
					val.tipo=INT;
				}
				$$=val;
}
	|Fator DIV termo{
			struct Valor val;
				if(($1).tipo==BOOL || ($3).tipo==BOOL){
					char msg[200];
					sprintf(msg, "Tipo BOOL incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}				
				else if((($1).tipo==STRING || ($3).tipo==STRING) || (($1).tipo==CHAR || ($3).tipo==CHAR)){
					char msg[200];
					sprintf(msg, " Tipo STRING/CHAR incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}
				else if(($1).tipo==DOUBLE || ($3).tipo==DOUBLE){
					val.dbl=(($1).tipo==DOUBLE?($1).dbl:(($1).tipo==FLOAT?($1).fl:($1).integer)) / (($3).tipo==DOUBLE?($3).dbl:(($3).tipo==FLOAT?($3).fl:($3).integer));
					val.tipo=DOUBLE;
				}				
				else if(($1).tipo==FLOAT || ($3).tipo==FLOAT){
					val.fl=(($1).tipo==FLOAT?($1).fl:($1).integer) / (($3).tipo==FLOAT?($3).fl:($3).integer);
					val.tipo=FLOAT;
				}
				else if(($1).tipo==INT || ($3).tipo==INT){
					val.fl=($1).integer / ($3).integer;
					val.tipo=FLOAT;
				}
				$$=val;
}
	|Fator REST termo{ 
			struct Valor val;
				if(($1).tipo==BOOL || ($3).tipo==BOOL){
					char msg[200];
					sprintf(msg, "Tipo BOOL incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}				
				else if((($1).tipo==STRING || ($3).tipo==STRING) || (($1).tipo==CHAR || ($3).tipo==CHAR)){
					char msg[200];
					sprintf(msg, " Tipo STRING/CHAR incompativel\n");
					yyerror(msg);
					exit(5);
					break;
				}
				else if(($1).tipo==INT || ($3).tipo==INT){
					val.integer=($1).integer % ($3).integer;
					val.tipo=INT;
				}
				else {
					char msg[200];
					sprintf(msg, " Tipo incompativel\n");
					yyerror(msg);
					exit(5);
                    break;
					
				}
				$$=val;
	}
  	|termo{$$=$1;}
	;

termo: 
	NUM_INT{$$=$1;}
    |NUM_FLOAT{$$=$1;}
	|NUM_DOUBLE{$$=$1;}
	|SUB NUM_INT{$$=$2; $$.integer = -$$.integer;}
	|SUB NUM_FLOAT{$$=$2; $$.fl = -$$.fl;}
	|SUB NUM_DOUBLE{$$=$2; $$.dbl = -$$.dbl;}
	|DPAR Expressao EPAR{$$=$2;}
	|BOOLEANO{$$=$1;}
	|STR{$$=$1;}
	|CARACTER{$$=$1;}
    |UMULT VAR{
        struct Valor v;
        int tipo;
        tipo=getTipo($2, variaveis, varCont);
        switch(tipo){
            case DOUBLE:
            case INT:
            case FLOAT:
            case STRING:
            case BOOL:
            case CHAR:
                {
                char msg[200];
    			sprintf(msg, " a variavel %s nao eh ponteiro\n", $2);
    	   		yyerror(msg);
    			exit(7);
    		    break;
                }
    		case PINT:
			    v.tipo=INT;
			    v.integer=getinteger($2, variaveis, varCont);
			    break;
            case PCHAR:
                v.tipo=CHAR;
			    v.caracter=getcaracter($2, variaveis, varCont);
			    break;
            case PSTRING:
                v.tipo=STRING;
			    v.str=getstr($2, variaveis, varCont);
			    break;
			case PDOUBLE:
                v.tipo=DOUBLE;
			    v.dbl=getdbl($2, variaveis, varCont);
			    break;
			case PFLOAT:
                v.tipo=FLOAT;
			    v.fl=getfl($2, variaveis, varCont);
			    break;
			case PBOOL:
                v.tipo=BOOL;
                v.bool=getbool($2, variaveis, varCont);
                break;
            default: {
                char msg[200];
    			sprintf(msg, " Declare a Variavel\n");
    	   		yyerror(msg);
    			exit(7);
    		    break;
            }
            }
        $$=v;
    }
    |UAND VAR{
        struct Valor v;
        int tipo;
        tipo=getTipo($2, variaveis, varCont);
        switch(tipo){
            case PINT:
            case PCHAR:
            case PSTRING:
            case PDOUBLE:
            case PFLOAT:
            case PBOOL:
                {
                char msg[200];
    			sprintf(msg, " a variavel %s ja guarda o local da memoria\n", $2);
    	   		yyerror(msg);
    			exit(7);
    		    break;
                }
    		case INT:
                v.tipo=PINT;
                v.pint=getpint($2, variaveis, varCont);
                break;
            case CHAR:
                v.tipo=PCHAR;
                v.pcaracter=getpchar($2, variaveis, varCont);
                break;
            case STRING:
                v.tipo=PSTRING;
                v.pstr=getpstring($2, variaveis, varCont);
                break;
            case DOUBLE:
                v.tipo=PDOUBLE;
                v.pdbl=getpdouble($2, variaveis, varCont);
                break;
            case FLOAT:
                v.tipo=PFLOAT;
                v.pfl=getpfloat($2, variaveis, varCont);
                break;
            case BOOL:
                v.tipo=PBOOL;
                v.pbool=getpbool($2, variaveis, varCont);
                break;
            default:
                {
                char msg[200];
    			sprintf(msg, " Declare a Variavel\n");
    	   		yyerror(msg);
    			exit(7);
    		    break;
            }
            }
        $$=v;
        }
    |VAR{
		int i, achou=0;
		for(i=0;i<varCont;i++){
			if(strcmp(variaveis[i].nome,$1)==0){
				$$ = variaveis[i].valor;
				achou=1;
				break;
			}
		}
		if(achou==0){
			char msg[200];
			sprintf(msg, " A variavel %s nao foi declarada\n", $1);
			yyerror(msg);
			exit(6);
		}
	}
	;
%%
