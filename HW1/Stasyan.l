%{
    #include <iostream>
    #include <string>

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
DIGIT [0-9]
DIGIT1 [1-9]
SYMS [a-z]
SYMBD [a-zA-Z0-9]
SYMB [A-Z]

%%
{TAB}                 
(else)|(false)|(if)|(loop)|(then)|(while)|(not)|(true)|(print)|(println) {std::cout << "Token class: KEYWORD,  Token value: " << yytext << std::endl;}
[0-9]+                {std::cout << "Token class: NUMBER,   Token value: " << yytext << std::endl;}
[A-Z][a-zA-Z0-9_]*    {std::cout << "Token class: TYPE_ID,  Token value: " << yytext << std::endl;}
[a-z][a-zA-Z0-9_]*    {std::cout << "Token class: VARIABLE, Token value: " << yytext << std::endl;}
"+"                   {std::cout << "Token class: OP,       Token value: ADD" << std::endl;}
"-"                   {std::cout << "Token class: OP,       Token value: SUB" << std::endl;}
"*"                   {std::cout << "Token class: OP,       Token value: MUL" << std::endl;}
"/"                   {std::cout << "Token class: OP,       Token value: DIV" << std::endl;}
"="                   {std::cout << "Token class: OP,       Token value: ASSIGN" << std::endl;}

"\""                  {BEGIN(STRING);}
"--"                  {BEGIN(STR_COMMENT);}
"("                   {BEGIN(PAR_COMMENT); parenthesis++;}
"/*"                  {BEGIN(SLASH_COMMENT);}

<STRING>[a-zA-Z0-9_]+ {current_str += yytext;}
<STRING>"\""          {std::cout << "Token class: STRING,   Token value: " << current_str << std::endl; current_str= ""; BEGIN(INITIAL);}
<STRING>"\n"          {current_str += "\\n";}

<STR_COMMENT>"\n"     {BEGIN(INITIAL);}
<STR_COMMENT>{SYMBD}

<PAR_COMMENT>"("      {parenthesis++;}
<PAR_COMMENT>")"      {parenthesis--; if (parenthesis == 0) {BEGIN(INITIAL);}}
<PAR_COMMENT>"\n"
<PAR_COMMENT>{SYMBD}

<SLASH_COMMENT>"*/"   {BEGIN(INITIAL);}
<SLASH_COMMENT>"\n"
<SLASH_COMMENT>{SYMBD}
%%