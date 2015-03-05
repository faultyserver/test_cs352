# Part 3

Part 3 of the project introduces a number of new features to our miniscript language. Briefly, they are:

  1. Arrays : `[1, 2, 3]`
  2. Boolean values : `true`, `false`
  3. Conditional operators : `&&`, `||`
  4. Equality operators : `==`, `!=`
  5. The negation operator : `!`
  6. Relational operators : `>`, `<`, `>=`, `<=`
  7. Conditional statements : `if ... else`
  8. Loops : `while`

In addition to these new features, new rules on error handling have been added. These include both new error types and different handling of the output for errors.

This document provides a brief overview of each of these features, as well as links to their respective sections. It is **not** the official definition of these features. Any errors here **can not** be considered evidence of ambiguity or confusion.


## Arrays
An array is any set of expression values combined into a single list, and stored in a variable. By that definition, arrays in miniscript can have contain any mixture of types, even `<undefined>`. Note that, like objects, miniscript does not allow for implicit array definitions, i.e. the expression `my_array == [1, 2, 3]` is invalid and will produce a syntax error.

A full definition and explanation of arrays can be found in the [Arrays section]() of this spec.


## Booleans
Boolean values are similar to those defined in C++ (and more recently introduced in C11). That is, the keywords `true` and `false` represent a distinct boolean type, rather than just a truthy or falsy value. While the implementation is free to handle booleans however it likes, there are a number of requirements for how they are represented elsewhere in the language that may affect how you choose to implement them.

A full definition and explanation of the boolean type can be found in the [Booleans section]() of this spec.


## New Operators
All operators in miniscript perform the same semantic actions and follow the same precedence rules as in C (and JavaScript for that matter). That is, operators follow the precedence (from lowest to highest priority):

  1. Logical Or `||`
  2. Logical And `&&`
  3. Equality `==`, `!=`
  4. Relation `<`, `>`, `<=`, `>=`
  5. Addition `+`, `-`
  6. Multiplication `*`, `/`
  7. Negation `!`
  8. Postfix `[]`, `.`

A full definition and explanation of *all* of these operators can be found in the [Operators section]() of this spec.


## Conditional Statements
Along with the new boolean values and operators, part 3 of the project introduces the standard `if ... else` conditional statement. Again, this statement performs exactly as it would in any other language. That is, the statement list between the `if` and the `else` will only be executed if the condition given to the `if` is met. Conversely, the statement list after the `else` will only be executed if it is not.

A full definition and explanation of the conditional statement can be found in the [Conditional Statements section]() of this spec.


## Loops
Loops in miniscript are currently limited to the simple `while` loop. Similar to C, the `while` loop will repeatedly execute the statement list that follows it until the condition given to it evaluates to `false`. Infinite loops are possible using expressions which always evaluate to `true`, though this is likely not going to be tested, as unit testing infinite loops is rather difficult.

A full definition and explanation of the loops supported by miniscript can be found in the [Loops section]() of this spec.


## Error Handling
The definition of error handling has been greatly improved following the ambiguities that came up during part 2 of the project. As of now, all errors **must** be written to `stderr` and be entirely contained on a single line. In other words, all errors will take the form:

    Line <line_num>, <error_type>\n

Where `<line_num>` is replaced by the number of the line from which the error *originated*, and `<error_type>` is replaced by the appropriate text for the error that is being reported.

Errors for *statements* are to only be reported once, meaning the implementation will need to keep track of whether or not a statement has previously thrown an error. Notice that this applies to *statements*, not *expressions*, meaning that even if a statement contains multiple errors, only the first one will be reported.

Because all of the expressions in the grammar for this project are left associative (the left side is evaluated first), determining the first error in a statement should be trivial.

A full definition and explanation of all possible errors and how they should be reported can be found in the [Error Handling section]() of this spec.
