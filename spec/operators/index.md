# 6 Operators
Operators are used to create complex expressions from multiple simple values. Multiple operators can be combined in a single expression any number of times, and the resulting value is determined by the precedence rules defined here.

Miniscript supports a subset of the operators available in C. However, all operators in miniscript follow the same precedence as their counterparts in C. For a full reference of operators and their precedence in C, see [this Wikipedia article](http://en.wikipedia.org/wiki/Operators_in_C_and_C%2B%2B#Operator_precedence).

The structure of this section is laid out in order from highest to lowest precedence. That is, when evaluating an expression, the order of operations applied in that expression could be determined by reading this list from top to bottom.

The current set of operators available in miniscript are:

  - `()`
  - `.`, `[]`
  - `!`
  - `*`, `/`
  - `+`, `-`
  - `>`, `<`, `>=`, `<=`
  - `==`, `!=`
  - `&&`
  - `||`

Note that the assignment operator, `=`, is not included here as miniscript treats assignment as a statement-level expression. Thus, it can not be used on the right-hand side of a statement, and is therefore not considered an operator.

**Note:** Any expression with any operand value of `<undefined>` will cause the *entire* expression to become `<undefined>`. This carries up through complex expressions.

## 6.1 Parenthetical
The parenthetical operator, `()`, indicates that the expression within it should be evaluated entirely before being used in part of any parent expression. That is, the entire order of operations is applied to the contained expression before its value is passed to the parent. It is used in the form

    '(' expression ')'

where `expression` can be any normal expression.

## 6.2 Postfix
Postfix operators are those which access some part of a containing data structure. By definition, then, these operators CAN NOT be used with any of the simple data types. Such expressions MUST throw a type violation.

### 6.2.1 `.`
Known as the "dot" operator, this operation extracts the value of a field from an object. It is used in the form

    ID '.' ID

where the first `ID` is the name of the object being accessed and the second `ID` is the name of the field to select. If the first `ID` does not identify a value with the type `object`, a type violation MUST be thrown.

If the field has not been declared as part of the object, an undeclared variable error MUST be thrown.

More reference on this can be found in the [Objects section on Access](../data_structures/objects.md#412-access).

### 6.2.2 `[]`
Known as the "subscript" operator, this operation extracts the value of a member from an array. It is used in the form

    ID '[' numeric_expression ']'

where `ID` is the name of the array being accessed and `numeric_expression` is any expression which evaluates to an integer. If the given `ID` does not identify a value with the type `array`, a type violation MUST be thrown.

If the index given by `numeric_expression` has not been *explicitly* declared (either in the array initializer or by an assignment statement), a value error MUST be thrown, and the value of the expression becomes `<undefined>`.

## 6.3 Negation
The negation operator, `!`, indicates that a given boolean value should be inverted. That is, `true` becomes `false` and `false` becomes `true`. It is used in the form

    '!' boolean_expression

where `boolean_expression` is either a variable identifier or a parenthetical expression.

Note that this operator can only be used on boolean values, as miniscript does not support implicit type casting.

## 6.4 Multiplicative
The multiplicative operators are the first arithmetic operations to be applied. Their meaning is the same as that in normal algebra. They take the forms

    numeric_expression '*' numeric_expression
    numeric_expression '/' numeric_expression

for division, where `numeric_expression` is any expression which evaluates to some numeric value.

Both of the operators have the same precedence. If both operators appear in a single expression, they should be evaluated from left to right. For example, the expression `2 * 4 / 8` would become `8 / 8`, which would then become `1`.

Any mathematical errors that occur while evaluating these expressions (such as division by 0), should be left for the language of implementation (normally C or C++) to handle. If an occurs and the implenting language does not fail, it causes *undefined behavior*.

Both of these operations are reserved for use only with numeric values. If any other value type appears on either side of the operator, a type violation MUST be thrown, and the value becomes `<undefined>`. Similarly, if the types of the two operands do not match, a type violation MUST be thrown, and the value becomes `<undefined>`.

## 6.5 Additive
The additive operators are the last arithmetic operations to be applied. Their meaning is the same as that in normal algebra. They take the forms

    expression '+' expression
    numeric_expression '-' numeric_expression

for subtraction, where `expression` is any normal expression which evaluates to either a string or numeric value and `numeric_expression` is any normal expression which specifically evaluates to a numeric value.

While subtraction is reserved for use only with numeric values, addition can be applied to strings. In this case, the two string values on either side of the operator are concatenated and the result is the combination of the two. For example, the expression `"Hello, " + "world!"` would result in the value `Hello, world!`.

If any other types appear on either side of the operator, a type violation MUST be thrown, and the value becomes `<undefined>`. Similarly, if the types of the two operands do not match, a type violation MUST be thrown, and the value becomes `<undefined>`.

## 6.6 Relational
The relational operators, `<`, `>`, `<=`, and `>=`, indicate that the given expression should be evaluated for its truthfulness based on its algebraic meaning. That is, the result of the operation is a boolean. These operators are used in the forms

    numeric_expression '<' numeric_expression
    numeric_expression '>' numeric_expression
    numeric_expression '<=' numeric_expression
    numeric_expression '>=' numeric_expression

where `numeric_expression` is any normal expression which evaulates to a numeric value.

As the productions imply, these operations are reserved for numeric values. If any other type appears on either side of the operator, a type violation MUST be thrown, and the value becomes `<undefined>`.

## 6.7 Equality
The equality operators, `==` and `!=`, are similar to the relational operators in that they evaluate the algebraic truthfulness of the given expression and return a boolean value. These operators are used in the forms

    expression '==' expression
    expression '!=' expression

where `expression` is any normal expression.

The primary difference between these and the relational operators is that these operators can compare any matching scalar values (numbers, strings, and booleans), not just numeric ones. However, the types of both operands still must match. If they do not, a type violation MUST be thrown, and the value becomes `<undefined>`.

If either of the operands is a data structure (object, array, etc.), a type violation MUST be thrown, and the value becomes `<undefined>`.

## 6.8 Logical And
The "logical and" operator, `&&` evaluates the truthfulness of both the first and the second operands. It is used in the form

    boolean_expression '&&' boolean_expression

where `boolean_expression` is any normal expression which evaluates to a boolean value.

The result of an expression using this operator is only `true` if both of its operands evaluate to the boolean value `true`. Otherwise, the value is `false`.

This operation is reserved for boolean values. If any other type appears on either side of the operator, a type violation MUST be thrown, and the value becomes `<undefined>`.

## 6.9 Logical Or
The "logical or" operator, `||`, has the lowest precedence of all operators and evaluates the truthfulness of *at least* one of its operands. It is used in the form

    boolean_expression '||' boolean_expression

where `boolean_expression` is any normal expression which evaluates to a boolean value.

The result of an expression using this operator is `true` if either or both of its operands evaluate to `true`. Otherwise, the value is `false`.

This operation is reserved for boolean values. If any other type appears on either side of the operator, a type violation MUST be thrown, and the value becomes `<undefined>`.
