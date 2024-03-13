To compile the lexer use next commands:
flex LexicalAnalysis.l
g++ lex.yy.c Logic.cpp

To test program with test.txt file use:
./a.out test.txt