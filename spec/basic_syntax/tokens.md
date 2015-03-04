# 2.1 Tokens
Tokens in miniscript fall into one of four categories: Keyword, Constant, Operator, and Other. This section defines the pattern that each token represents, what it is used for, and any special cases that come up.

## 2.1.1 Keyword Tokens
Miniscript only defines a small number of keyword tokens. These strings are reserved for use as keywords and MUST cause a syntax error if used in any other context. By convention, keyword token names in this spec will have the format `k<keyword_name>`. This is not a requirement, but simply a stylistic choice to improve readability.

|   Name   |              Pattern              |                        Meaning                         |
| -------- | --------------------------------- | :----------------------------------------------------- |
| `kSTART` | `<script type="text/JavaScript">` | Mark the start of a miniscript program                 |
| `kEND`   | `</script>`                       | Mark the end of a miniscript program                   |
| `kVAR`   | `var`                             | Indicate that the next token will be an identifier     |
| `kWRITE` | `document.write`                  | Tell the parser to print out the following expressions |
| `kTRUE`  | `true`                            | Indicate a value that always evaluates to true         |
| `kFALSE` | `false`                           | Indicate a value that always evaluates to false        |

## 2.1.2 Constant Token Types
Along with the keyword token types defined above, miniscript understands three other types of tokens. Again, the token names here are not required, but are simply chosen to improve readability.

|   Name   |         Pattern         |          Meaning           |
| -------- | ----------------------- | :------------------------- |
| `ID`     | `[a-zA-Z][a-zA-Z0-9_]*` | A variable name            |
| `NUM`    | `[0-9]+`                | A literal numeric constant |
| `STRING` | `\"[^\"\n]*\"`          | A literal string constant  |

**A note on the definition of `STRING`**: The given regex for a string literal matches a pair of double quotes with anything except for another double quote or a newline character between them. This works based off of the rule that strings CAN NOT contain a newline character, and the assumption that strings WILL NOT contain a double quote inside of them.

See the [Data Types section on Strings]() for more information on these rules.

## 2.1.3 Operator Tokens
The implementation is free to choose how to handle operator tokens. Many implementers like to define them as token types, and then use those types in their grammar for the language. Others like to include the literal characters themselves in the grammar. Both methodologies are valid, and the only realistic difference between them is personal preference.

In either case, reference the [Operators section]() for information on which tokens need to be defined.

## 2.1.4 Other Characters
Whitespace characters (spaces and tabs) are ignored by miniscript as insignificant, other than to separate otherwise ambiguous tokens. Past the lexical analyzer, they serve no purpose and can thus be discarded.

Newline characters, colons, and semicolons (`\n`, `:`, `;`) all serve special purposes in the grammar of some statements, and thus need to be passed along for the grammar to handle.

If any other tokens appear in a miniscript program, the lexical analyzer should reject it as unrecognized. How the parser behaves afterwards is *undefined behavior*. Most implementations choose to fail hard and stop execution upon seeing this.
