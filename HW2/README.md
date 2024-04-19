# Сборка проекта

# О проекте
Проект выполнен студентом 2-го курса ФРКТ МФТИ Воложиновым Дмитрием в рамках курса по компиляторам от базовой организации "Сбер".
# Описание грамматики
Терминальные символы:
Заглавные и строчные латинские буквы и нижнее подчёркивание - для задания переменных 
"+", "-", "\*", "/", "(", ")" - для выполнения арифметических операций
Нетерминальные символы:
E - выражение из слагаемых, разделённых знаками "+" и "-"
T - выражение из множителей, разделённых знаками "\*" и "/"
F - выражение в скобках или идентификатор
id - непосредственно токен (константа или переменная)
Стартовый символ: E
Список продукций:
E -> E + T | E - T | T
T -> T * F | T / F | F
F -> (E) | id