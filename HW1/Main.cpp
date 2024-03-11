#include <fstream>
#include <iostream>

int main(int argc, char* argv[]) {
    argv++;
    argc--; 
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;

    yylex();
    return 0;
}