%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
extern int yylineno;
extern char *yytext;
int yylex(void);
void yyerror(const char *s);
%}

%token PROGRAM BASLA BITIR DEGISKEN
%token TIP_SAYI TIP_ONDALIK TIP_YAZI
%token EYER ISE DEGILSE SON_EYER
%token DONGU YAP SON_DONGU
%token IDENTIFIER INT_CONST FLOAT_CONST CHAR_CONST STRING_CONST
%token EQ NEQ LE GE LAND LOR

/* Operator Oncelikleri (Asagidan yukariya dogru oncelik artar) */
%left LOR
%left LAND
%left EQ NEQ
%left '<' '>' LE GE
%left '+' '-'
%left '*' '/' '%'
%right '!' UMINUS

%%

program:
    PROGRAM IDENTIFIER BASLA statements BITIR
    ;

statements:
    /* bos blok olabilir */
    | statements statement
    ;

statement:
    var_decl
    | assignment
    | conditional
    | loop
    | ';'
    ;

/* Degisken Tanimlama: degisken a, b = 5: sayi; */
var_decl:
    DEGISKEN var_list ':' data_type ';'
    ;

data_type:
    TIP_SAYI | TIP_ONDALIK | TIP_YAZI
    ;

var_list:
    var_item
    | var_list ',' var_item
    ;

var_item:
    IDENTIFIER
    | IDENTIFIER '=' expression
    ;

/* Atama: sayac = sayac + 1; */
assignment:
    IDENTIFIER '=' expression ';'
    ;

/* Kosul Yapisi: eyer (...) ise ... degilse ... son_eyer; */
conditional:
    EYER '(' expression ')' ISE statements SON_EYER ';'
    | EYER '(' expression ')' ISE statements DEGILSE statements SON_EYER ';'
    ;

/* Dongu Yapisi: dongu (...) yap ... son_dongu; */
loop:
    DONGU '(' expression ')' YAP statements SON_DONGU ';'
    ;

/* Aritmetik, Karsilastirma ve Mantiksal Ifadeler */
expression:
    expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | expression '%' expression
    | expression EQ expression
    | expression NEQ expression
    | expression '<' expression
    | expression '>' expression
    | expression LE expression
    | expression GE expression
    | expression LAND expression
    | expression LOR expression
    | '!' expression
    | '-' expression %prec UMINUS
    | '(' expression ')'
    | IDENTIFIER | INT_CONST | FLOAT_CONST | CHAR_CONST | STRING_CONST
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error at line %d: unexpected '%s'\n", yylineno, yytext);
}

int main(int argc, char **argv) {
    if (argc > 1 && !(yyin = fopen(argv[1], "r"))) {
        fprintf(stderr, "Hata: Dosya acilamadi: %s\n", argv[1]);
        return 1;
    }

    if (yyparse() == 0) {
        printf("OK\n");
        return 0;
    }
    return 1;
}
