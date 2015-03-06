# 7.2 Loops
Conditional statements are those which optionally execute a set of statements only if a given condition is met.

Most conditional statements involve the use of keyword tokens, the definitions for which can be found in the [Basic Syntax section on Keyword Tokens](../basic_syntax/tokens.md#211-keyword-tokens).

## 7.2.1 `while`
A `while` loop repeatedly executes its body as long the given condition evaluates to `true`. It follows the production rule

    kWHILE '(' boolean_expression ')' '{' '\n' statement_list '\n' '}' '\n'

where `boolean_expression` is any normal expression which evaluates to a boolean value, and `statement_list` is any sequence of statements (declaration, assignment, write, conditional, loops, etc.).

The execution of `statement_list` depends on `boolean_expression` evaluating to the boolean value `true`. If it is `false`, then `statement_list` will NOT be executed.

After `statement_list` has been executed (if it has), `boolean_expression` will be re-evaluated. If it is still `true`, `statement_list` will be executed again, and the process will repeat until `boolean_expression` evaluates to `false`.

If `boolean_expression` evaluates to anything other than a boolean value, a type violation MUST be thrown, and `statement_list` will NOT be executed.

Notice the inclusion of two newline characters (`\n`) in the production rule. These characters are required and if they are not present, a syntax error MUST be thrown. This applies to all other literal characters in the rule as well.

## 7.2.2 `do ... while`
The `do ... while` loop is a variation of the normal `while` loop. The primary difference is that the conditions given to the `while` are checked *after* each iteration, rather than *before*. It follows the production rule

    kDO '{' '\n' statement_list '\n' '}' '\n' kWHILE '(' boolean_expression ')'

where `statement_list` is any sequence of statements (declaration, assignment, write, conditional, loops, etc.), and `boolean_expression` is any normal expression which evaluates to a boolean value.

As stated previously, the only difference between this and the regular `while` loop is when `boolean_expression` is evaluated. Other than that, all conditions, type rules, and nuances apply in the same way.
