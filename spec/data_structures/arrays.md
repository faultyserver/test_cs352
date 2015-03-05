# 4.2 Arrays
Arrays in miniscript are defined as a special subtype of objects. That is, they are functionally equivalent in every way except for those differences shown here. Arrays have entries known as *members*, capable of taking on any value and type as defined in the [Data Types section](../data_types/index.md).

## 4.2.1 Initialization
The initialization of an array uses the same syntax as found in most other programming languages. A quick reference can be found in the [JSON section on arrays](https://www.json.com/json-array). Like objects, a miniscript array is only allowed to contain simple value types (numbers, strings, booleans), and is **not** allowed to contain other miniscript data structures (objects, arrays, etc.).

In miniscript, the production rule for initializating an array is

    kVAR ID '=' '[' optional_member_list ']'

where `ID` is the name of the array and `optional_member_list` is a potentially-blank, comma-delimited sequence of expressions. If the list is blank, then no newlines can appear between the two brackets (`[` and `]`). That is, a blank initialization MUST be fully contained in a single line:

    var array = [ ];

The members of an array are allowed to mix types among the simple data types. For example, the array declaration

    var array = ["John Smith", 150];

would create the array `array` with a string member `John Smith`, and a number member `150`.

If an array declaration spans multiple lines, then the commas delimiting the members MUST be on the same line as their preceding member initializaiton. Otherwise a syntax error MUST be thrown. For example, the input

    var array = [
      "John Smith",
      150
    ];

would would initialize the array `array` in the same way as the previous statement, but the declaration

    var array = [
      "John Smith"
      , 150
    ];

would cause a syntax error.

An array initialization in miniscript differs from many other languages in that it is a statement-level expression. That is, arrays can only be initialized in a declaration statement. If an array initialization appears anywhere else (such as an assignment or write statement), a syntax error MUST be thrown. For example, the assignment statement

    array = [ ]

would cause a syntax error.

Any deviation from the above rules MUST throw a syntax error. Further reference can be found in the [Data Structures section on Objects](objects.md#41-objects).

## 4.2.2 Access
The production rule

    ID '[' numeric_expression ']'

specifies the access of a member from an array, where `ID` represents the name of the array, and `numeric_expression` is any expression which evaluates to an integer representing the index of the member being accessed. Member access is a *normal expression operation*, meaning it can appear anywhere on the right-hand side of a statement.

Arrays in miniscript are *0-based*, meaning the first member of the array is at position 0 and is accessed by `array[0]`. Similarly, the last member of the array has an index of the length of the array minus 1.

For example, the following input represents the declaration of an array and the access of its first member in an assignment to a new variable.

    var array = ["John Smith", 150];
    var name = array[0];

Notice that the production rule does not allow recursion. This is in compliance with the constraint that miniscript arrays can not contain other structures, as discussed above.

If a request is made to any other index that has not been *explicitly* defined (either by the initialization or an assignment statement, shown below), a value error MUST be thrown, and the value of the expression becomes `<undefined>`.

## 4.2.3 Appending Members
Members can be appended to arrays after they have been initialized. For this section, assume the array `array` has been declared as:

    var array = ["John", "Smith", 150];

From here, it is possible to add new members to the array using an assignment statement in the form of

    member_access = expression

where `member_access` is an access expression as defined in the previous section. For example, the input

    array[3] = "Jan. 01, 1990"

would append a new member at index `3` of `array` with the value `Jan. 01, 1990`. (The index is 3 because arrays are 0-based, meaning the fourth element - the one being added - has the index 4 - 1 = 3).

This syntax can also be used to rewrite existing members. For example, the input

    array[1] = "Doe";

would overwrite the original value of the second member of the array with the new value `Doe`.

## 4.2.4 Copy Behavior
Similar to objects, arrays themselves are not allowed to appear on the right-hand side of any statement. Because of this, it is illegal to copy an array to a new variable. If it does, a type violation MUST be thrown.

For example, the input

    var array = [ "John Smith" ];
    var other = array;

would cause a type violation on the second line.

This behavior differs greatly from other languages, where arrays are treated as normal variables and are allowed to be copied.
