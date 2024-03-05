%{
    #include <iostream>
    #include <string>
    #include <cctype>

    int parenthesis = 0;
    std::string current_str = "";
%}
%option yylineno
%option noyywrap
%option main

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
KEYWORD ((e|E)(l|L)(s|S)(e|E))|(f(a|A)(l|L)(s|S)(e|E))|((i|I)(f|F))|((l|L)(o|O)(o|O)(p|P))|((t|T)(h|H)(e|E)(n|N))|((w|W)(h|H)(i|I)(l|L)(e|E))|((n|N)(o|P)(t|T))|(t(r|R)(u|U)(e|E))|((p|P)(r|R)(i|I)(n|N)(t|T))|((p|P)(r|R)(i|I)(n|N)(t|T)(l|L)(n|N))
UNEXPECTED [\~\@\№\!\#\$\;\:\%\^\&\>\<\?\`\[\]\\\|\/\{\}\.\,\0\001\002\003\004]
NOTTAB [a-zA-Z0-9\_\+\-\*\/\=\~\@\№\!\#\$\;\:\%\^\&\>\<\?\`\[\]\\\|\/\{\}\.\,\0\001\002\003\004]

%%
{TAB}                 
{KEYWORD}             {std::cout << "Token class: KEYWORD,  Token value: " << yytext << std::endl;}
{DIGIT}+              {std::cout << "Token class: NUMBER,   Token value: " << yytext << std::endl;}
{SYMB}{SYMBD}*        {std::cout << "Token class: TYPE_ID,  Token value: " << yytext << std::endl;}
{SYMS}{SYMBD}*        {std::cout << "Token class: VARIABLE, Token value: " << yytext << std::endl;}
"+"                   {std::cout << "Token class: OP,       Token value: ADD" << std::endl;}
"-"                   {std::cout << "Token class: OP,       Token value: SUB" << std::endl;}
"*"                   {std::cout << "Token class: OP,       Token value: MUL" << std::endl;}
"/"                   {std::cout << "Token class: OP,       Token value: DIV" << std::endl;}
"="                   {std::cout << "Token class: OP,       Token value: ASSIGN" << std::endl;}

"\""                  {BEGIN(STRING);}
"--"                  {BEGIN(STR_COMMENT);}
"("                   {BEGIN(PAR_COMMENT); parenthesis++;}
"/*"                  {BEGIN(SLASH_COMMENT);}

{UNEXPECTED}          {std::cout << "SYNTAX ERROR" << std::endl; return 0;}

<STRING>{SYMBD}+      {current_str += yytext;}
<STRING>"\""          {std::cout << "Token class: STRING,   Token value: " << current_str << std::endl; current_str= ""; BEGIN(INITIAL);}
<STRING>"\n"          {current_str += "\\n";}

<STR_COMMENT>"\n"     {BEGIN(INITIAL);}
<STR_COMMENT>{TABNON}
<STR_COMMENT>{NOTTAB}

<PAR_COMMENT>"("      {parenthesis++;}
<PAR_COMMENT>")"      {parenthesis--; if (parenthesis == 0) {BEGIN(INITIAL);}}
<PAR_COMMENT>{TAB}
<PAR_COMMENT>{NOTTAB}

<SLASH_COMMENT>"*/"   {BEGIN(INITIAL);}
<SLASH_COMMENT>{TAB}
<SLASH_COMMENT>{NOTTAB}
%%
