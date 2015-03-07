# 8 Errors
Errors in miniscript come in many varities. This section explains how each one comes up, it's format, and any special cases it may have.

In a statement, only the first error contained by it will be reported. For example, the input

    <script type="text/JavaScript">
    var x = 1 + "string" && 1 + "string";
    </script>

would only report a single violation:

```
Line 2, type violation

```

even though there are two violations in the statement.

# Index

  - [8.1 Syntax Errors](syntax.md#81-syntax-errors)
    - [8.1.1 Source](syntax.md#811-source)
    - [8.1.2 Print Format](syntax.md#812-print-format)
    - [8.1.3 Special Cases](syntax.md#813-special-cases)
  - [8.2 Type Violations](type.md#82-type-violations)
    - [8.2.1 Source](type.md#821-source)
    - [8.2.2 Print Format](type.md#822-print-format)
    - [8.2.3 Special Cases](type.md#823-special-cases)
  - [8.3 Undeclared Variable Errors](undeclared.md#83-undeclared-variable-errors)
    - [8.3.1 Source](undeclared.md#831-source)
    - [8.3.2 Print Format](undeclared.md#832-print-format)
    - [8.3.3 Special Cases](undeclared.md#833-special-cases)
  - [8.4 Unwritten Variable Errors](unwritten.md#84-unwritten-variable-errors)
    - [8.4.1 Source](unwritten.md#841-source)
    - [8.4.2 Print Format](unwritten.md#842-print-format)
    - [8.4.3 Special Cases](unwritten.md#843-special-cases)
  - [8.5 Unknown Condition Errors](unknown_condition.md#85-unknown-condition-errors)
    - [8.5.1 Source](unknown_condition.md#851-source)
    - [8.5.2 Print Format](unknown_condition.md#852-print-format)
    - [8.5.3 Special Cases](unknown_condition.md#853-special-cases)
