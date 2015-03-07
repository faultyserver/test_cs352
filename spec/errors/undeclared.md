# 8.3 Undeclared Variable Errors
Undeclared variable errors occur when a variable which has not previously been declared is referenced in a statement.

Undeclared variable errors do NOT stop the execution of the input. Instead, execution continues as if nothing had gone wrong.

## 8.1.1 Source
Undeclared variable errors are caused by the reference of a variable which has not been declared (either by a declaration or a previous assignment statement) on the left-hand side of an assignment statement.

For example, the input

    <script type="text/JavaScript">
    x = 1;
    </script>

would cause an undeclared variable error on line 2, as the variable `x` has not been previously declared. However, after this statement is executed, the variable `x` will be declared. By this logic, an undeclared variable error can only ever occur once for an input as variables can never become *undeclared*. See the [Variables section](../variables/index.md#51-properties) for more information.

Because data structures have their fields/members dynamically initialized, it is impossible for them to incur an undeclared variable error.

## 8.1.2 Print Format
Undeclared variable errors MUST be printed with the format

```
Line <x>, <variable_name> undeclared

```

where `<x>` is the line number of the start of the *expression* which contains the violation, and `<variable_name>` is the name of the variable being referenced.

Notice the there is a newline at the end of the output.

## 8.1.3 Special Cases
Undeclared variable errors have no special cases. All undeclared variable errors are handled in the exact same way.
