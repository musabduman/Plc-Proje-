%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
#include "anahtar_kelimeler.h"

/* Anahtar kelime -> Token eslestirme tablosu */
typedef struct {
    const char *kelime;
    int token;
} Keyword;

static Keyword keywords[] = {
    {KELIME_PROGRAM,   PROGRAM},   {KELIME_BASLA,     BASLA},
    {KELIME_BITIR,     BITIR},     {KELIME_DEGISKEN,  DEGISKEN},
    {KELIME_SAYI,      TIP_SAYI},  {KELIME_ONDALIK,   TIP_ONDALIK},
    {KELIME_YAZI,      TIP_YAZI},  {KELIME_EYER,      EYER},
    {KELIME_ISE,       ISE},       {KELIME_DEGILSE,   DEGILSE},
    {KELIME_SON_EYER,  SON_EYER},  {KELIME_DONGU,     DONGU},
    {KELIME_YAP,       YAP},       {KELIME_SON_DONGU, SON_DONGU}
};

/* Gelen kelimenin anahtar kelime mi yoksa degisken adi mi oldugunu bulur */
int check_keyword(const char *s) {
    int count = sizeof(keywords) / sizeof(keywords[0]);
    for (int i = 0; i < count; i++) {
        if (strcmp(s, keywords[i].kelime) == 0)
            return keywords[i].token;
    }
    return IDENTIFIER;
}
%}

%option noyywrap
%option yylineno

%%

("#"|"//")[^\n]*        { /* Comment lines are ignored */ } /* Commands and whitespaces */
[ \t\r\n]+              { /* Spaces and new lines are ignored */ }

[0-9]+"."[0-9]+         { return FLOAT_CONST; } /* Decimal literal */
[0-9]+                  { return INT_CONST; } /*Integer literal */
'([^'\\\n]|\\.)'        { return CHAR_CONST; } /* Character literal */
\"([^\"\\\n]|\\.)*\"    { return STRING_CONST; } /* String literal */

[-+*/%!<>():;,=]        { return yytext[0]; } /* Operators and punctuation */
[a-zA-Z][a-zA-Z0-9_]*   { return check_keyword(yytext); } /* Identifier */
.                       { return yytext[0]; }

"=="                    { return EQ; }
"!="                    { return NEQ; }
"<="                    { return LE; }
">="                    { return GE; }
"&&"                    { return LAND; }
"||"                    { return LOR; }

%%
