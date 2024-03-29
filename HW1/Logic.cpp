#include "Logic.hpp"

extern char* yytext;
extern int yylineno;
extern int parenthesis;
extern std::string current_str;

void error(int code) {
    switch (code)
    {
    case 1:
        std::cout << "LEXICAL ERROR";
        break;
    case 2:
        std::cout << "UNCLOSED COMMENT";
        break;
    default:
        std::cout << "UNKNOWN ERROR CODE";
        break;
    }

    std::cout << "; LINE: " << yylineno << std::endl;
    exit(0);
}

void operation_call(char OP) {
    std::cout << "Token class: OP,       Token value: ";
    switch (OP)
    {
    case '+':
        std::cout << "ADD";
        break;
    case '-':
        std::cout << "SUB";
        break;
    case '*':
        std::cout << "MUL";
        break;
    case '/':
        std::cout << "DIV";
        break;
    case '=':
        std::cout << "ASSIGN";
        break;
    }
    std::cout << std::endl;
}

void keyword_call(std::string word) {
    std::cout << "Token class: KEYWORD,  Token value: " << word << std::endl;
}

void number_call() {
    std::cout << "Token class: NUMBER,   Token value: " << yytext << std::endl;
}

void type_call() {
    std::cout << "Token class: TYPE_ID,  Token value: " << yytext << std::endl;
}

void var_call() {
    std::cout << "Token class: VARIABLE, Token value: " << yytext << std::endl;
}

void string_record() {
    current_str += yytext;
}

void string_recordln() {
    current_str += "\\n";
}

void string_close() {
    std::cout << "Token class: STRING,   Token value: " << current_str << std::endl; 
    current_str= "";
}

void par_open() {
    parenthesis++;
}

int par_close() {
    parenthesis--;
    if (parenthesis == 0)
        return 1;
    return 0;
}