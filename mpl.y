%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
extern char *yytext;
int yylex(void);
void yyerror(const char *s);
int error_count = 0;
%}

%token PROGRAM BASLA BITIR
%token DEGISKEN
%token TIP_SAYI TIP_VIRGUL TIP_YAZI
%token EYER ISE DEGILSE SON_EYER
%token DONGU YAP SON_DONGU
%token IDENTIFIER
%token INT_CONST FLOAT_CONST CHAR_CONST STRING_CONST

%token EQ NEQ LE GE LAND LOR
%token ASSIGN

/* Operator Precedence and Associativity */
%left LOR
%left LAND
%left EQ NEQ
%left '<' '>' LE GE
%left '+' '-'
%left '*' '/' '%'
%right '!' UMINUS

%%

program:
    PROGRAM IDENTIFIER BASLA statement_list BITIR
    | PROGRAM IDENTIFIER BASLA BITIR
    ;

statement_list:
    statement_list statement
    | statement
    ;

statement:
    var_declaration
    | assignment_stmt
    | conditional_stmt
    | loop_stmt
    | ';'
    ;

/* Değişken Tanımlama: degisken a, b: sayi; veya degisken x = 10: sayi; */
var_declaration:
    DEGISKEN var_init_list ':' data_type ';'
    ;

data_type:
    TIP_SAYI
    | TIP_VIRGUL
    | TIP_YAZI
    ;

var_init_list:
    var_init_list ',' var_init_item
    | var_init_item
    ;

var_init_item:
    IDENTIFIER
    | IDENTIFIER ASSIGN expression
    ;

/* Değişkene Değer Atama: sayac = sayac + 1; */
assignment_stmt:
    IDENTIFIER ASSIGN expression ';'
    ;

/* Koşul Yapısı (If-Else) */
conditional_stmt:
    EYER '(' expression ')' ISE statement_list SON_EYER ';'
    | EYER '(' expression ')' ISE statement_list DEGILSE statement_list SON_EYER ';'
    | EYER '(' expression ')' ISE SON_EYER ';'
    | EYER '(' expression ')' ISE DEGILSE statement_list SON_EYER ';'
    ;

/* Döngü Yapısı (While Loop) */
loop_stmt:
    DONGU '(' expression ')' YAP statement_list SON_DONGU ';'
    | DONGU '(' expression ')' YAP SON_DONGU ';'
    ;

/* Aritmetik, Mantıksal ve Karşılaştırma İfadeleri */
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
    | primary_expr
    ;

primary_expr:
    IDENTIFIER
    | INT_CONST
    | FLOAT_CONST
    | CHAR_CONST
    | STRING_CONST
    ;

%%

void yyerror(const char *s) {
    error_count++;
    fprintf(stderr, "Syntax error at line %d: unexpected '%s'\n", yylineno, yytext);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        extern FILE *yyin;
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            fprintf(stderr, "Hata: Dosya acilamadi: %s\n", argv[1]);
            return 1;
        }
        yyin = f;
    }

    if (yyparse() == 0 && error_count == 0) {
        printf("OK\n");
        return 0;
    } else {
        return 1;
    }
}
