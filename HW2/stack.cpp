#include "stack.hpp"

AnalyzerStack::AnalyzerStack() {
    stack[0] = Elem::bottom;
    iterator = 1;
}

void AnalyzerStack::shift(int token) {
    stack[iterator] = token;
    ++iterator;
}

int AnalyzerStack::reduce() {

}