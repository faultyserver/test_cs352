# 3.2 Strings
Strings in miniscript are essentially any set of characters surrounded by double quotes. A more formal definition can be found in the [Basic Syntax section on Constant Token Types](../basic_syntax/tokens.md#212-constant-token-types).

## 3.1.1 String Literals
String literals are any occurrence of the `STRING` token in the input.

## 3.1.2 Limitations
Strings themselves are **not** allowed to contain double quote (`"`) or newline (`\n`) characters. For example, the input `"1 string"` is a valid string literal. However, `2 string` is not because it is not surrounded by quotes. The input

    "string with newline
    "

is **not** allowed as it contains a newline character (`\n`) inside of it. This case MUST throw a syntax error.

Similarly, the input

    "string with a " "

is **not** a string literal in its entirety. The first part of the input, `"string with a "`, will be matched as a string literal, which is followed by another double quote character. The second double quote indicates the start of another string literal, which may or may not throw a syntax error following the other conditions given above.

## 3.1.3 Representation
The implementation is free to decide how to represent string values internally. Externally, string values appear exactly as they would be given in the input, without the surrounding double quotes. For example, the string literal `"I am a string"`, when printed, would appear as `I am a string` (no quotes).

String literals with the same value MUST evaluate to `true` when used in an equality (`==`). In the same vein, any string value from a variable, expression, or any other means MUST be treated as equal to its corresponding string literal. For example, `"some " + "string" == "some string"` MUST evaluate to `true`.

The string `<br />` has a special meaning in miniscript. If it appears as the entirety of the value of a string, then, when printed, the implementation should instead print a newline character (`\n`). If it appears as a *substring* (partial value, e.g., `"some string<br />"`) of a string, it causes *undefined behavior*. **For now, implementations can assume that this case will not occur.**
