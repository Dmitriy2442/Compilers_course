enum Grammar {
    LR0, // only implement this
    LR1,
    LALR,
    NONE
};

template <Grammar G> class SyntaxAnalyzer{};

template<> class SyntaxAnalyzer<LR0> {
private:

public:
    
};