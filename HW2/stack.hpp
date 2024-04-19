#include <vector>

enum Elem{
    bottom = 0,
    id1 = 1,
    id2 = 2,
    F = 3,
    T = 4,
    E = 5,
    add = 6,
    sub = 7,
    mul = 8,
    div = 9,
    oppar = 10,
    clpar = 11
};

class AnalyzerStack {
private:
    std::vector<int> stack;
    int iterator;
public:
    AnalyzerStack();
    void shift(int token);
    int reduce();
};