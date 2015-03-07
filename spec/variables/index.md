# 5 Variables
Variables in miniscript act in the same way as variables in any other language. That is, they are some identifier which represents a non-constant value (one that can be changed).

Variables are identified by the `ID` token as given in the [Basic Syntax section on Constant Token Types](../basic_syntax/tokens.md#212-constant-token-types).

## 5.1 Properties
Variables have two boolean properties which affect their usage in different parts of an input.

| Property |                          Meaning                         |
| -------- | -------------------------------------------------------- |
| Declared | The variable has been properly initialized by the input. |
| Written  | The variable has been *explicitly* given a value.        |

These properties are referenced in this section as "declared", "undeclared", "written", and "unwritten", where the "un-" prefix means that the value of the property is false.

Referencing any variable that is *unwritten* MUST result in a "has no value" error. Referencing any variable that is *undeclared* MUST result in a type violation.

## 5.2 Declaration
Variables in miniscript are defined using the declaration statement, as given in the [Basic Syntax section on Statements](../basic_syntax/statements.md#231-declaration). For reference, a declaration statement takes one of the forms

    kVAR ID
    kVAR ID '=' expression

where `ID` is the identifier of the variable to be created (the target), and `expression` is any normal expression. These are the *only* statements which legally create new variables.

In the first case, the new variable is given the value `<undefined>`, and is considered *declared* but *unwritten*. In the second case, the new variable is given the value that comes from evaluating `expression`, and is considered both *declared* and *written* (even if the value is `<undefined>`).

Declaration statements can also be used to re-declare variables. That is, a declaration statement can include variables that already exist. In this case, the declaration statement acts as an assignment statement. If the first declaration form is used, the value becomes `<undefined>`, and the variable is once again considered *declared* but *unwritten*.

## 5.3 Assignment
The assignment statement, as given in the [Basic Syntax section on Statements](../basic_syntax/statements.md#232-assignment), takes the form

    ID '=' expression

where `ID` is the identifier of the variable being assigned (the target), and `expression` is any normal expression.

An assignment statement assumes that the variable identified by `ID` has already been declared. However, if the variable has *not* been previously declared, an assignment statement will create it as a new variable with the value from `expression`, but MUST throw a type violation. After this, the variable will be considered *undeclared* but *written*.

## 5.4 Declared vs. Undeclared
A variable is considered *declared* only if it has been explicitly used in a declaration statement (shown above). Being *declared* does not mean the variable has a value.

*Undeclared* variables only come up if the variable being referenced has not previously been the target of a declaration statement.

If a variable is referenced before it has been declared, the variable remains *undeclared* until a declaration statement targeting the variable has been made.

Assignment statements targeting undeclared variables cause the variable to become *declared*.

## 5.5 Written vs. Unwritten
A variable is considered *written* only if it has been explicitly given a value either through a declaration statement (with an expression) or an assignment statement. Even if the value of the variable is `<undefined>`, the variable is still considered to be *written*.

*Unwritten* variables only come up in two situations:

  1. The variable has not been previously declared.
  2. The variable was declared without an expression (the second form of declaration).

If a variable is referenced before it has been written, the variable remains *unwritten* until either a declaration (with an expression) or an assignment statement targeting the variable has been made.

## 5.6 Scope
All variables in miniscript are considered to be in the "global scope". That is, once a variable is defined by the input, it is available to *all* future lines of input, even if it was declared inside of a block such as an `if` or `while` statement.

This applies to re-declaration as well. For example, if a variable is first declared with a value outside of a loop, and is then re-declared inside of the loop without a value, the variable will be remain *unwritten* after the exiting the loop.

This differs from most other languages (namely C) where variables defined inside of structures are not available outside of them.
