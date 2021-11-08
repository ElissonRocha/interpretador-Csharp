/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_CSHARP_H_INCLUDED
# define YY_YY_CSHARP_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BREAK = 258,
     TIPO = 259,
     VAR = 260,
     ATRIB = 261,
     PRINT = 262,
     WRITE = 263,
     STR = 264,
     CARACTER = 265,
     BOOLEANO = 266,
     NUM_INT = 267,
     NUM_FLOAT = 268,
     NUM_DOUBLE = 269,
     SOMA = 270,
     SUB = 271,
     DIV = 272,
     MULT = 273,
     UMULT = 274,
     EPAR = 275,
     DPAR = 276,
     SEMICOLON = 277,
     COMP = 278,
     DIF = 279,
     NOT = 280,
     MAIOR = 281,
     MENOR = 282,
     MAIGUAL = 283,
     MEIGUAL = 284,
     INCREM = 285,
     DECREM = 286,
     NOTBIT = 287,
     REST = 288,
     IS = 289,
     AS = 290,
     UAND = 291,
     AND = 292,
     XOR = 293,
     OR = 294,
     CAND = 295,
     COR = 296,
     CNULA = 297,
     COND = 298,
     DOISPONTOS = 299,
     VIRGULA = 300
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 60 "csharp.y"

	char* ident;
	int tipo;
	struct Valor valor;
	struct Nomes nnomes;


/* Line 2058 of yacc.c  */
#line 110 "csharp.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_CSHARP_H_INCLUDED  */
