%{
    #include <iostream>
    #include <string>
    #include <cctype>
    #include "Logic.hpp"

    int parenthesis = 0;
    std::string current_str = "";
%}
%option yylineno
%option noyywrap

%x STR_COMMENT
%x PAR_COMMENT
%x SLASH_COMMENT
%x STRING

TAB [ \t\v\n]+
TABNON [ \t]+
DIGIT [0-9]
DIGIT1 [1-9]
SYMS [a-z]
SYMBD [a-zA-Z0-9\_]
SYMB [A-Z]
UNEXPECTED [\~\@\№\!\#\$\;\:\%\^\&\>\<\?\`\[\]\\\|\/\{\}\.\,\0\001\002\003\004]
NOTTAB [a-zA-Z0-9\_\+\-\*\/\=\~\@\№\!\#\$\;\:\%\^\&\>\<\?\`\[\]\\\|\/\{\}\.\,\0\001\002\003\004]

%%
{TAB}      

(e|E)(l|L)(s|S)(e|E)                    {keyword_call("else");}
f(a|A)(l|L)(s|S)(e|E)                   {keyword_call("false");}
(i|I)(f|F)                              {keyword_call("if");}
(l|L)(o|O)(o|O)(p|P)                    {keyword_call("loop");}
(t|T)(h|H)(e|E)(n|N)                    {keyword_call("then");}
(w|W)(h|H)(i|I)(l|L)(e|E)               {keyword_call("while");}
(n|N)(o|P)(t|T)                         {keyword_call("not");}
t(r|R)(u|U)(e|E)                        {keyword_call("true");}
(p|P)(r|R)(i|I)(n|N)(t|T)               {keyword_call("print");}
(p|P)(r|R)(i|I)(n|N)(t|T)(l|L)(n|N)     {keyword_call("println");}

{DIGIT}+              {number_call();}
{SYMB}{SYMBD}*        {type_call();}
{SYMS}{SYMBD}*        {var_call();}


"+"                   {operation_call('+');}
"-"                   {operation_call('-');}
"*"                   {operation_call('*');}
"/"                   {operation_call('/');}
"="                   {operation_call('=');}

"\""                  {BEGIN(STRING);}
"--"                  {BEGIN(STR_COMMENT);}
"("                   {BEGIN(PAR_COMMENT); par_open();}
"/*"                  {BEGIN(SLASH_COMMENT);}

{UNEXPECTED}          {error(1);}
.

<STRING>{SYMBD}+      {string_record();}
<STRING>"\""          {string_close(); BEGIN(INITIAL);}
<STRING>"\n"          {string_recordln();}
<STRING>.

<STR_COMMENT>"\n"     {BEGIN(INITIAL);}
<STR_COMMENT>{TABNON}
<STR_COMMENT>{NOTTAB}
<STR_COMMENT>.

<PAR_COMMENT><<EOF>>  {error(2);}
<PAR_COMMENT>"("      {par_open();}
<PAR_COMMENT>")"      {if (par_close()) {BEGIN(INITIAL);}}
<PAR_COMMENT>{TAB}
<PAR_COMMENT>{NOTTAB}
<PAR_COMMENT>.

<SLASH_COMMENT><<EOF>> {error(2);}
<SLASH_COMMENT>"*/"    {BEGIN(INITIAL);}
<SLASH_COMMENT>{TAB}
<SLASH_COMMENT>{NOTTAB}
<SLASH_COMMENT>.
%%

#include "Main.cpp"
