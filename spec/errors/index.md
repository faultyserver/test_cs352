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

  - [8.1 Syntax Errors](syntax.md)
  - [8.2 Type Violations](type.md)
  - [8.3 Undeclared Variable Errors](undeclared.md)
  - [8.4 Unwritten Variable Errors](unwritten.md)
  - [8.5 Unknown Condition Errors](unknown_condition.md)
