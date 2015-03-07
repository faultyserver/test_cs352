# 8.1 Syntax Errors
Syntax errors occur while parsing an input. Specifically, the are handled by the parser and are defined by the grammar/production rules themselves.

A syntax error MUST cause the parsing of the input to stop and terminate the program.

## 8.1.1 Source
Syntax errors are caused by any input which does not follow a production rule.

For example, if the grammar requires an `=` character to follow the `ID` token in an assignment, but the input provides a `-`, a syntax error would be thrown.

## 8.1.2 Print Format
Syntax errors MUST be printed with the format

```
syntax error

```

Notice that there is a newline at the end of the output.

## 8.1.3 Special Cases
Syntax errors have no special cases. All syntax errors are handled in exactly the same way.
