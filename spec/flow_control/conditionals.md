# 7.1 Conditionals
Conditional statements are those which optionally execute a set of statements only if a given condition is met.

Most conditional statements involve the use of keyword tokens, the definitions for which can be found in the [Basic Syntax section on Keyword Tokens](../basic_syntax/tokens.md#211-keyword-tokens).

## 7.1.1 `if ... else`
The `if ... else` construct is really a combination of two conditional statements. However, the dependence of the `else` statement on the `if` statement means that combinations of the two can (and should) be considered variations of a single statement.

In addition, unlike most other languages, the combination statement `else if` is treated as a special case, and not just an `else` statement followed by an `if` statement.

### 7.1.1.1 `if`
An `if` statement conditionally executes its body if the given condition evaluates to `true`. It follows the production rule

    kIF '(' boolean_expression ')' '{' '\n' statement_list '\n' '}'

where `boolean_expression` is any normal expression which evaluates to a boolean value, and `statement_list` is any sequence of statements (declaration, assignment, write, conditional, loops, etc.).

The execution of `statement_list` depends on `boolean_expression` evaluating to the boolean value `true`. If it is `false`, then `statement_list` will NOT be executed.

If `boolean_expression` evaluates to anything other than a boolean value, a type violation MUST be thrown, and `statement_list` will NOT be executed.

Notice the inclusion of two newline characters (`\n`) in the production rule. These characters are required and if they are not present, a syntax error MUST be thrown. This applies to all other literal characters in the rule as well.

If an `if` statement is not followed immediately by an `else` or `else if` statement, another newline character (`\n`) MUST appear immediately after the closing brace (`}`). If this is not present, a syntax error MUST be thrown.

### 7.1.1.2 `else if`
In miniscript, the `else if` construct is treated as a special statement, rather than just an `if` statement contained by an `else` statement. It follows the production rule

    if_statement kELSE if_statement

where `if_statement` is either an `if` statement as defined above, or another `else if` statement.

The execution of the second `if_statement` depends on whether or not the first `if_statement` was executed. If it was, then the second `if_statement` will NOT be executed; if it was not, then the second `if_statement` will be executed (subject to its own conditions, as given above).

### 7.1.1.3 `else`
An `else` statement follows the production rule

    if_statement kELSE '{' '\n' statement_list '\n' '}' '\n'

where `if_statement` is either an `if` or `else if` statement as defined above, and `statement_list` is any sequence of statements (declaration, assignment, write, conditional, loops, etc.).

The execution of `statement_list` depends on whether or not the preceding `if` statement was executed. If it was, then `statement_list` will NOT be executed; if it was not, then `statement_list` will be executed.

Notice the inclusion of three newline characters (`\n`) in the production rule. These characters are required and if they are not present, a syntax error MUST be thrown. This applies to all other literal characters in the rule as well.
