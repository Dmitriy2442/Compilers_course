#include <stdlib.h>

void error(int code) {
    switch (code)
    {
    case 1:
        std::cout << "SYNTAX ERROR";
        break;
    case 2:
        std::cout << "UNCLOSED COMMENT";
    default:
        std::cout << "UNKNOWN ERROR CODE";
        break;
    }

    std::cout << "; LINE: " << yylineno << std::endl;
    exit(0);
}