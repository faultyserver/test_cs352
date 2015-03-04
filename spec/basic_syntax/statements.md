# 2.3 Statements
A statement is any standalone "expression" (note that normal expressions are **not** allowed to be on exist on their own) inside of the miniscript program. To avoid confusion, we will specifically use the term "statement" when referring to any of the following productions, and the term "expression" only when referring to normal expressions as discussed in the [Expressions section]().

Currently, our miniscript language understands three types of statements:

  1. **Declaration:** a new variable is created.
  2. **Assignment:** an existing variable is overwritten.
  3. **Write:** data is written to stdout.

Statements can be followed by either a semicolon, a newline, or both. In any case, at least one of them must be present, otherwise a syntax error MUST be thrown.

## 2.3.1 Declaration
A declaration statement can follow one of two production rules. The first rule is simply

    kVAR ID

which indicates that a variable with name `ID` should be created and given the value `<undefined>`.

The second is

    kVAR ID '=' expression

which indicates that a variable with the name `ID` should be created and given whatever value comes out of evaluating `expression`. This process is specifically known as "initialization".

## 2.3.2 Assignment
An assignment statement differs from a declaration statement in that the variable `ID` is expected to have been previously declared (created). That is, an assignment statement will not normally create a new variable. The production rule for an assignment is simply

    ID '=' expression

There is a special way to handle the case when the variable does not exist, which is discussed in the [Error Handling section on Assignment Statements]().

## 2.3.3 Write
A write statement works in an entirely different way from the other two. The production rule for it is

    kWRITE '(' parameter_list ')'

where `parameter_list` is a comma-delimited list of expressions to be written to stdout.
