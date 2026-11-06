%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
#include "anahtar_kelimeler.h"

int check_keyword(const char *s) {
    if (strcmp(s, KELIME_PROGRAM) == 0) return PROGRAM;
    if (strcmp(s, KELIME_BASLA) == 0) return BASLA;
    if (strcmp(s, KELIME_BITIR) == 0) return BITIR;
    if (strcmp(s, KELIME_DEGISKEN) == 0) return DEGISKEN;
    if (strcmp(s, KELIME_SAYI) == 0) return TIP_SAYI;
    if (strcmp(s, KELIME_VIRGUL) == 0) return TIP_VIRGUL;
    if (strcmp(s, KELIME_YAZI) == 0) return TIP_YAZI;
    if (strcmp(s, KELIME_EYER) == 0) return EYER;
    if (strcmp(s, KELIME_ISE) == 0) return ISE;
    if (strcmp(s, KELIME_DEGILSE) == 0) return DEGILSE;
    if (strcmp(s, KELIME_SON_EYER) == 0) return SON_EYER;
    if (strcmp(s, KELIME_DONGU) == 0) return DONGU;
    if (strcmp(s, KELIME_YAP) == 0) return YAP;
    if (strcmp(s, KELIME_SON_DONGU) == 0) return SON_DONGU;
    return IDENTIFIER;
}
%}

%option noyywrap
%option yylineno

DIGIT       [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGIT})*

%%

"#"[^\n]*               { /* Yorum satırları (# ile başlayanlar yoksayılır) */ }
"//"[^\n]*              { /* Yorum satırları (// ile başlayanlar da yoksayılır) */ }
[ \t\r\n]+              { /* Boşluk ve yeni satırlar yoksayılır */ }

{DIGIT}+"."{DIGIT}+     { return FLOAT_CONST; }
{DIGIT}+                { return INT_CONST; }
'([^'\\\n]|\\.)'        { return CHAR_CONST; }
\"([^\"\\\n]|\\.)*\"    { return STRING_CONST; }

"=="                    { return EQ; }
"!="                    { return NEQ; }
"<="                    { return LE; }
">="                    { return GE; }
"&&"                    { return LAND; }
"||"                    { return LOR; }
"="                     { return ASSIGN; }

"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"%"                     { return '%'; }
"!"                     { return '!'; }
"<"                     { return '<'; }
">"                     { return '>'; }
"("                     { return '('; }
")"                     { return ')'; }
":"                     { return ':'; }
";"                     { return ';'; }
","                     { return ','; }

{ID}                    { return check_keyword(yytext); }

.                       { return yytext[0]; }

%%
