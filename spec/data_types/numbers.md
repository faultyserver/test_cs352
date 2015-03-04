# 3.1 Numbers
Numbers in miniscript are any values whose representation fit the `NUM` token as defined in the [Basic Syntax section on Constant Token Types](../basic_syntax/tokens.md#212-constant-token-types).

## 3.1.1 Numeric Literals
Numeric literals are any occurrence of the `NUM` token in the input.

## 3.1.2 Limitations
Currently, miniscript only supports positive integral values (whole numbers). Numbers such as `0.00`, `3.14`, and `-1` are invalid and MUST throw a syntax error.

Note that even though negative *literal* values are not allowed, negative *result* values are allowed to come out of expressions. For example, the expression `1 - 2` would result in a value of `-1` without any errors, while the expression `1 + -2` would cause a syntax error on the token `-2`.

## 3.1.3 Representation
The implementation is free to decide how to represent numeric values internally. Externally, numeric values must appear exactly as they would if they were to be part of the input. That is, the value `1`, when printed, would appear as `1`. No modifiers (i.e. `0x`, `(d)`, etc) should be added to the value.

Numeric literals with the same value MUST evaluate to `true` when used in an equality (`==`). In the same vein, any numeric value from a variable, expression, or any other means MUST be treated as equal to its corresponding numeric literal. For example, `1 + 2 == 3` MUST evaluate to `true`.
