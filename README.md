# CS 352 Test Script
A small(ish) test script for the compiler project in CS 352. Features include:

  - Written in Ruby. ([Yes, that's a feature](http://yehudakatz.com/2009/08/24/my-10-favorite-things-about-the-ruby-language/)) (Yes, there's a Python port)
  - Named test cases.
  - Negated test cases.
  - Colorized output.
  - Failure log to help with debugging.

Requires [Ruby >= 1.8.7](https://www.ruby-lang.org/en/downloads/). Works on Mac and Linux. Works on Windows with `make` installed and support for ANSI codes ([ansi.sys](http://support.microsoft.com/kb/101875)).

##### Planned for v1.0:

  - Complex file structure support.
  - Better support for windows.
  - Case tagging for faster development.
  - Assertion support for compiler validation.
  

# Staying up to date
If you choose to clone this repo (e.g., `git clone https://github.com...`), you can easily make sure that you have the most recent version of the test cases just by running `git pull`.

The `master` branch is guaranteed to have the most recent, confirmed-valid test cases. Therefore, it can be trusted to always be inline with the official spec.

Other branches may have more recent and expansive tests, but they are not guaranteed to be correct. If you would like to test with them, you can run `git checkout <the_branch>` to load them locally. All pull requests will be loaded to these branches first, then merged into master when they have been fully validated and confirmed.
  
# Usage
Make a new folder (generally called `test`) in your project folder, e.g.:

    project/
    |- ...
    |- parser.l
    |- parser.y
    |- test/
    |- Makefile
    |- ...
    
Copy this repo to that directory, such that you have the structure:

    project/
    |- ...
    |- parser.l
    |- parser.y
    |- test/
    |  |- tests/
    |  |- test.rb
    |- Makefile
    |- ...
    
Configure `test.rb` to fit your project. The configuration options are at the top of the file, and each option has a description of what it controls as a comment.
    
Run the testing script from the root of your project directory with

``` shell
$ ruby ./test/test.rb     # To use Ruby, or
$ python ./test/test.py   # To use Python
```

To make things even easier, you can add a `test` rule to your Makefile. The testing script already includes a call to `make`, so you something like the following should work:

``` make
# Makefile
...
.PHONY: test
test:
  ruby ./test/test.rb     # To use Ruby, or
  python ./test/test.py   # To use Python
```

Notice that we also added a `.PHONY` rule. This tells make that it should always run the `test` rule, even if it has run it before.

From there, calling `make test` should be enough to run the full set of tests. For example (using the Ruby script):

``` shell
$ make test
ruby ./test/test.rb
CS 352 Project Test Script [Ruby v0.9] - Jon Egeland, 2015

Setup:
------
Tester:   ./parser
Test dir: ./test/tests/*


Tests:
------
passed: empty statements
passed: multiple statements without separators
passed: no ending keyword
passed: no starting keyword
passed: single line non-blank script
FAILED: single line script
passed: standalone expression
passed: string arithmetic
passed: text after end
passed: text before start
passed: arithmetic expressions
passed: blank script
passed: blank script with newlines
passed: full script
passed: multiple statements ending with semi
passed: multiple statements per line
passed: parameter lists
passed: statement with ending semi
passed: statement without ending semi
passed: variable assignment
passed: variable declaration


Results:
--------
20/21 tests passed.
Errors have been logged in: test_failures.log
```


# Writing Tests
Test cases are kept in the `tests/` folder. Included are a number of test cases for various aspects of the project.

Every file in the `tests/` folder will be run by the test script.

Importantly, test cases are language-independent, meaning you only need to write one version of each test, and it will automatically be used between all versions of the test script.

## Named Tests
The name of a test is given by the name of its file. By convention, files named with the prefix `test_` will have the prefix removed from their name.

For example, say we have the following test cases:

    test_something_simple
    test_something_more_complicated
    test_a_stupidly_long_test_case_name_that_should_not_really_be_used

These cases would be interpreted by the script as:

    something simple
    something more complicated
    a stupdily long test case name that should not really be used
  
  
## Negated tests
Negated tests are tests that are expected to fail. Since the nature of testing a parser doesn't really allow for `assert` statements, we need another way to differentiate these cases from normal ones.

The test script will interpret any test cases prefixed with `err_` as a case that is expected to fail.

For example:

    test_something_should_work           # Expected to pass
    err_test_something_should_not_work   # Expected to fail


# Contributing
There are two main ways to contribute: adding test cases and modifying the test script.

## Test Cases
If you would like to contribute test cases, fork this repo, add your cases, then make a pull request. Please limit pull requests to relevant test cases (i.e., testing the same aspect) to make validation and case management easier.

If you find an error in any of the test cases, create a new issue with the following information:

  - The test case name (preferably the name of the file, but the actual name is okay, too).
  - The problematic portion of the case. Cases can get fairly long, so please include only the relevant lines, along with the line number.
  - The reason that the case is invalid. References to the official spec will help the issue get fixed faster.
  - (Optional) A fix for the test case. If you have a fix for the case, provide it. It is okay to create an issue without a solution. If the test case can not be fixed (i.e., the purpose of the case is invalid), say so in your issue.
  - Tag the issue with the `test_case` and `bug` labels.
  
Please, do **not** use pull requests to change existing test cases.

## Test Script
If you want to modify the test script, fork the repo, make your change, then make a pull request. Modifications will only be included if they *improve* the functionality or usability of the script. Stylistic changes are generally not accepted.

If you find an error in the test script, create an issue with the following:
  - The error that is occurring.
  - The lines of code where you think the error is occurring.
  - (Optional) A potential fix for the error. It is okay if you do not have one.
  
Please, do **not** use pull requests to fix bugs in the test script unless you reference an issue in your request.


# Licensing
Under [GNU GPL v3.0](http://www.gnu.org/copyleft/gpl.html).

Everyone is free to use and modify this code.
