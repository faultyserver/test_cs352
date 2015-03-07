# 8.4 Unwritten Variable Errors
Undeclared variable errors occur when a variable which has not previously been written to is referenced in a statement.

Unwritten variable errors do NOT stop the execution of the input. Instead, the value of the variable reference becomes `<undefined>` (however, the variable is NOT assigned this value), and execution continues normally.

Unwritten variable errors can also be called "value errors" or "has no value errors".

## 8.4.1 Source
Unwritten variable errors are caused by the reference of a variable which has not been explicitly assigned a value (either by a declaration or an assignment statement) on the right-hand side of a statement.

For example, the input

    <script type="text/JavaScript">
    var x;
    var y = x;
    </script>

would cause an unwritten variable error on line 3, as the variable `x` has been declared, but has not been assigned a value and is therefore *unwritten*. See the [Variables section](../variables/index.md#51-properties) for more information.


## 8.4.2 Print Format
Unwritten variable errors MUST be printed with the format

```
Line <x>, <variable_name> has no value

```

where `<x>` is the line number of the start of the *expression* which contains the violation, and `<variable_name>` is the name of the variable being referenced.

Notice the there is a newline at the end of the output.

## 8.4.3 Special Cases
If the variable being referenced is a field of an object, the print format becomes

```
Line <x>, <object_name>.<variable_name> has no value

```

where `<object_name>` is the name of the object that the field supposedly belongs to.

If the variable being referenced is a member of an array, the print format becomes

```
Line <x>, <array_name>[<variable_name>] has no value

```

where `<array_name>` is the name of the array that the member supposedly belongs to.
