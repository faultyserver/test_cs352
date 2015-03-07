# 8.5 Unknown Condition Errors
Unknown condition errors occur when the value of a conditional expression is `<undefined>`.

Unknown condition errors do NOT stop the execution of the input. Instead, the flow control statement containing the error is skipped and execution continues with the following statement.

## 8.5.1 Source
Unknown condition errors are caused by a conditional expression being used in a flow control statement and having the value `<undefined>`.

Note that it is unlikely for this error to occur, as `<undefined>` values are not common in normal execution and are generally caused by other errors. Since only one error is reported for each statement, this error will get suppressed by any lower-level errors.

## 8.5.2 Print Format
Unknown condition errors MUST be printed with the format

```
Line <x>, condition unknown

```

where `<x>` is the line number of the start of the *expression* which contains the violation.

Notice that there is a newline at the end of the output.

## 8.5.3 Special Cases
Unknown condition errors have no special cases. All unknown condition errors are handled in exactly the same way.
