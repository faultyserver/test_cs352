# 4.1 Objects
Objects in miniscript are functionally analagous to objects in most other languages, most closely resembling JavaScript. Objects have *fields*, which are attributes of that object, capable of taking on any value and type as defined in the [Data Types section](../data_types/index.md).

## 4.1.1 Initialization
The initialization of an object uses a simplified version of the [JSON syntax](http://json.org/). Notably miniscript only supports scalar fields. That is, a miniscript object is only allowed to contain simple value types (numbers, strings, booleans), and is **not** allowed to contain other miniscript data structures (objects, arrays, etc.).

The production rule for initializing an object is

    kVAR ID '=' '{' optional_initializer_list '}'

where `ID` is the name of the object and `optional_initializer_list` is a potentially-blank, comma-delimited sequence of field initializations. If the list is blank, then no newlines can appear between the two brackets (`{` and `}`). That is, a blank initialization MUST be fully contained in a single line:

    var object = { };

A field initialization has the production rule

    field_name ':' expression

Field initializations MUST fully contain themselves in a single line. That is, a newline character is not allowed to appear anywhere in the production rule given above. As this rule implies, fields will ALWAYS be assigned a value.

A sequence of field initializations is created by joining multiple field initializations into a list, with commas between each initializer. For example,

    var object = { first_name: "John", last_name: "Smith", age: 150 };

If the object initialization spans multiple lines, then the commas delimiting the fields MUST be on the same line as its preceding field initializaiton. Otherwise a syntax error MUST be thrown. For example,

    var object = {
      first_name: "John",
      last_name: "Smith",
      age: 150
    }

would initialize the object `object` in the same way as the previous statement, but the declaration

    var object = {
      first_name: "John"
      , last_name: "Smith"
      , age: 150
    }

would cause a syntax error.

An object initialization in miniscript differs from many other languages in that it is a statement-level expression. That is, objects can only be initialized in a declaration statement. If an object initialization appears anywhere else (such as an assignment or write statement), a syntax error MUST be thrown. For example, the assignment statement

    object = { }

would cause a syntax error.

Any deviation from the above rules MUST throw a syntax error.

## 4.1.2 Access
The production rule

    ID '.' ID

specifies the access of a field from an object, where the first `ID` represents the name of the object and the second `ID` represents the name of the field. Field access is a *normal expression operation*, meaning it can appear anywhere on the right hand side of a statement.

For example, the following input represents the declaration of an object and the access of one of its fields in an assignment to a new variable.

    var object = { name: "John Smith" };
    var my_name = object.name;

Notice that the production rule does not allow recursion. This is in compliance with the constraint that miniscript objects can not contain other structures, as discussed above.

If a field has not previously been declared for an object, a type violation MUST be thrown, and the value of the expression becomes `<undefined>`.

Similarly, if the first `ID` of the production rule does not identify an existing object, a type violation MUST be thrown as field access can only be performed on objects.

This operation is discussed in further detail in the [Postfix Operators section]().

## 4.1.3 Appending Fields
Fields can be appended to objects after they have been initialized. For this section, assume the object `object` has been declared as:

    var object = { first_name: "John", last_name: "Smith", age: 150 };

From here, it is possible to add new fields to the object using an assignment statement in the form of

    field_access = expression

where `field_access` is an access expression as defined in the previous section. For example, the input

    object.birthday = "Jan. 01, 1990"

would create a new field, `birthday`, on the object `object`, and assign it the string value `Jan. 01, 1990`.

This syntax can also be used to rewrite fields. For example, the input

    object.last_name = "Doe"

would overwrite the original value of the field `last_name` with the new string value `Doe`.

## 4.1.4 Copy Behavior
Objects themselves are not allowed to appear on the right-hand side of any statement. Because of this, it is illegal to copy an object to a new variable. If it does, a type violation MUST be thrown.

For example, the input

    var object = { name: "John Smith" };
    var other = object;

would cause a type violation on the second line.

This behavior differs greatly from other languages, where objects are treated as normal variables and are allowed to be copied.
