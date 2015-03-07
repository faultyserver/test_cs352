# 8.2 Type Violations
Type violations occur when the type of an expression does not match its expected type.

Type violations do NOT stop the execution of the input. Instead, the value of its containing expression becomes `<undefined>` and the execution continues as normal with that value.

## 8.2.1 Source
Type violations are caused by any expression whose value type does not match the type which its parent is expecting.

For example, given an input like

    <script type="text/JavaScript">
    var a = 1 + "string";
    </script>

would cause a type violation on line 2, as the `+` operator requires both operands to either be string or integer types, they can not be mixed.

Below is a full list of causes of type violations:

  1. Mismatched operand types
  2. Unxpected operand types
  3. Appearance of a data structure on the right-hand side
  4. Reference to a variable which has not been previously declared
  5. Reference to an object field which has not yet been declared
  6. Reference to an array member which has not yet been declared
  7. Usage of any scalar value type as a data structure
  8. Usage of any data structure as a scalar value

## 8.2.2 Print Format
Type violations MUST be printed with the format

```
Line <x>, type violation

```

where `<x>` is the line number of the start of the *expression* which contains the violation. Even if a statement spans multiple lines, the given line number MUST match the lowest-level expression which contains the violation.

Notice that there is a newline at the end of the output.

For example, the input

    <script type="text/JavaScript">
    var a = 1 + "string"
    </script>

would report the type violation for `1 + "string"` as

```
Line 2, type violation

```

## 8.2.3 Special Cases
Type violations do not have any special cases. However, they are relatively general and can be caused by a wide variety of inputs.
