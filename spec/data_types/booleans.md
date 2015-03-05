# 3.3 Booleans
Booleans in miniscript are binary values. That is, they can either be "true" or "false". Boolean literals are keywords in miniscript, and their definition can be found in the [Basic Syntax section on Keyword Tokens](../basic_syntax/tokens.md#211-keyword-tokens).

## 3.3.1 Boolean Literals
Boolean literals are any occurrence of either the `kTRUE` or `kFALSE` tokens in the input.

## 3.3.2 Limitations
Booleans are only capable of holding the values "true" and "false". Any other value MUST throw a type violation and the value becomes `<undefined>`.

Because of how type rules are enforced in miniscript, expressions which do not evaluate to a boolean type CAN NOT be used as if they did. This invalidates the use of many common paradigms from other languages such as `while(1)` (this statement will throw a type violation).

## 3.3.3 Representation
The implementation is free to decide how to represent boolean values internally. Externally, boolean values should appear as either `true` or `false` when printed, corresponding to the value of the boolean.

Boolean literals with the same value MUST evaluate to `true` when used in an equality (`==`). In the same vein, any boolean value from a variable, expression, or any other means MUST be treated as equal to its corresponding boolean literal. For example, `1 > 2 == false` MUST evaluate to `true`.
