# 2.2 Program Structure
A miniscript program must contain *at least* the following tokens:

  1. A **single** `kSTART` token at the beginning of the script, followed immediately by a newline character.
  2. A **single** `kEND` token at the end of the script, preceded immediately by a newline character.

For an empty script, the two newline characters can be compressed into the same one. This results in a Minimum Compilable Source of:

    <script type="text/JavaScript">
    </script>

If either of these two conditions are not met, a syntax error MUST be thrown.

