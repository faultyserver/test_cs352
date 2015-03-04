# 2. Basic Syntax
This section defines the basic syntactic structure of a miniscript program, namely the keywords, tokens, and basic statements that the language accepts.


## 2.1 Tokens

### 2.1.1 Keyword Tokens
Miniscript only defines a small number of keyword tokens. These strings are reserved for use as keywords and MUST cause a syntax error if used in any other context. By convention, keyword token names in this spec will have the format `k<keyword_name>`. This is not a requirement, but simply a stylistic choice to improve readability.

|   Name   |              Pattern              |                        Meaning                         |
| -------- | --------------------------------- | :----------------------------------------------------- |
| `kSTART` | `<script type="text/JavaScript">` | Mark the start of a miniscript program                 |
| `kEND`   | `</script>`                       | Mark the end of a miniscript program                   |
| `kVAR`   | `var`                             | Indicate that the next token will be an identifier     |
| `kWRITE` | `document.write`                  | Tell the parser to print out the following expressions |
| `kTRUE`  | `true`                            | Indicate a value that always evaluates to true         |
| `kFALSE` | `false`                           | Indicate a value that always evaluates to false        |

### 2.1.2 Constant Token Types
Along with the keyword token types defined above, miniscript understands three other types of tokens. Again, the token names here are not required, but are simply chosen to improve readability.

|   Name   |         Pattern         |          Meaning           |
| -------- | ----------------------- | :------------------------- |
| `ID`     | `[a-zA-Z][a-zA-Z0-9_]*` | A variable name            |
| `NUM`    | `[0-9]+`                | A literal numeric constant |
| `STRING` | `\"[^\"\n]*\"`          | A literal string constant  |

**A note on the definition of `STRING`**: The given regex for a string literal matches a pair of double quotes with anything except for another double quote or a newline character between them. This works based off of the rule that strings CAN NOT contain a newline character, and the assumption that strings WILL NOT contain a double quote inside of them.

See the [Data Types section on Strings]() for more information on these rules.

### 2.1.3 Operator Tokens
The implementation is free to choose how to handle operator tokens. Many implementers like to define them as token types, and then use those types in their grammar for the language. Others like to include the literal characters themselves in the grammar. Both methodologies are valid, and the only realistic difference between them is personal preference.

In either case, reference the [Operators section]() for information on which tokens need to be defined.

### 2.1.4 Other Characters
Whitespace characters (spaces and tabs) are ignored by miniscript as insignificant, other than to separate otherwise ambiguous tokens. Past the lexical analyzer, they serve no purpose and can thus be discarded.

If any other tokens appear in a miniscript program, the lexical analyzer should reject it as unrecognized. How the parser behaves afterwards is *undefined behavior*. Most implementations choose to fail hard and stop execution upon seeing this.


## 2.2 Program Structure
A miniscript program must contain *at least* the following tokens:

  1. A **single** `kSTART` token at the beginning of the script, followed immediately by a newline character.
  2. A **single** `kEND` token at the end of the script, preceded immediately by a newline character.

For an empty script, the two newline characters can be compressed into the same one. This results in a Minimum Compilable Source of:

    <script type="text/JavaScript">
    </script>

If either of these two conditions are not met, a syntax error MUST be thrown.


## 2.3 Statements
A statement is any standalone "expression" (note that normal expressions are **not** allowed to be on exist on their own) inside of the miniscript program. To avoid confusion, we will specifically use the term "statement" when referring to any of the following productions, and the term "expression" only when referring to normal expressions as discussed in the [Expressions section]().

Currently, our miniscript language understands three types of statements:

  1. **Declaration:** a new variable is created.
  2. **Assignment:** an existing variable is overwritten.
  3. **Write:** data is written to stdout.

Statements can be followed by either a semicolon, a newline, or both. In any case, at least one of them must be present, otherwise a syntax error MUST be thrown.

### 2.3.1 Declaration
A declaration statement can follow one of two production rules. The first rule is simply

    kVAR ID

which indicates that a variable with name `ID` should be created and given the value `<undefined>`.

The second is

    kVAR ID '=' expression

which indicates that a variable with the name `ID` should be created and given whatever value comes out of evaluating `expression`. This process is specifically known as "initialization".

### 2.3.2 Assignment
An assignment statement differs from a declaration statement in that the variable `ID` is expected to have been previously declared (created). That is, an assignment statement will not normally create a new variable. The production rule for an assignment is simply

    ID '=' expression

There is a special way to handle the case when the variable does not exist, which is discussed in the [Error Handling section on Assignment Statements]().

### 2.3.3 Write
A write statement works in an entirely different way from the other two. The production rule for it is

    kWRITE '(' parameter_list ')'

where `parameter_list` is a comma-delimited list of expressions to be written to stdout.
