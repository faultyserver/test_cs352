
# test.py - Python port of test.rb
# - Josh Selbo, Jon Egeland, 2015
#
# Error-based testing for CS 352, Project 1.
#
# This script runs a set of tests, saying they passed as long as stderr is blank. Negated tests
# are also supported, such that tests that are designed to fail will show up as "passed" if they do.
#
#
# Works off of naming conventions:
#   Files in the `tests` directory that start with `test_` are test cases.
#   Files starting with `err_` will have its validity negated (i.e., passes on failure)
#   Names must:
#     - Not contain spaces
#     - Separate words with underscores (not dashes)
#
# Tests are passed to the program using their file name as the first argument, for example:
#     ./parser test_something_broken
#     => something simple: failed
#     ./parser err_test_something_broken
#     => something simple: passed


# Really, Python
from __future__ import print_function
# Read stdout and stderr from shell calls
import subprocess as sp
# Glob call
import glob
import os



#####
### CONFIGURATION ###
#####

# The name of the program to test with
TESTER = './parser'

# The location of the tests. Used as a glob pattern.
TEST_DIR = './test/tests/*'

# The name of the file to log test results in.
# The file will be rewritten every time this tester is run.
ERR_FILE = 'test_failures.log'





#####
### SOURCE
#####


# Colorization
def colorize(color_code, text):
  return "\033[%dm%s\033[0m" % (color_code, text)
def red(text):
  return colorize(31, text)
def green(text):
  return colorize(32, text)
def yellow(text):
  return colorize(33, text)

# Initial notification
version = 'CS 352 Project Test Script [Python v0.9] - 2015'
print(version)
print("\nSetup:")
print("------")
print("Tester:   ", TESTER)
print("Test dir: ", TEST_DIR)



# Ensure the program exists
sp.call('make')

# Open the log file
log = open(ERR_FILE, 'w')



# Keep track of passed vs. total
numPassed = 0
totalCases = 0

# Run the tests
print("\n\nTests:")
print("------")
for t in glob.glob(TEST_DIR):

  # Extract the test name
  name = t.split('/')[-1]

  # Determine if the test is supposed to pass or fail
  expectedErr = name.startswith('err_')

  # Format the test case name
  if expectedErr: name = name.replace('err_', '')
  name = name.replace('test_', '').replace('_', ' ')

  # Run the test
  output = sp.Popen('%s %s' % (TESTER, t), shell=True, stderr=sp.PIPE).stderr.read()
  failed = output != ''

  # Determine whether or not it passed
  result = 'passed' if (failed == expectedErr) else 'FAILED'

  # Write failures to the log
  if failed != expectedErr:
    if expectedErr: log.write("Expected 'fail' for \"%s\" (got 'pass')" % (name))
    else: log.write("Expected 'pass' for \"%s\" (got 'fail'): \n%s\n\n" % (name, output))

  # Print the result
  if result == 'passed': print(green("%s: %s" % (result, name)))
  else: print(red("%s: %s" % (result, name)))


  # Iterate the counters
  totalCases +=1
  if result == 'passed': numPassed+=1


# Close the log file
log.close()


if totalCases > 0: ratio = numPassed / totalCases
else: ratio = 0

passed_text = "%d/%d tests passed." % (numPassed, totalCases)
if ratio >= 1:     passed_text = green(passed_text)
elif ratio >= 0.8: passed_text = yellow(passed_text)
else:              passed_text = red(passed_text)

# Final notification
print("\n\nResults:")
print("--------")
print(passed_text)
print("Errors have been logged in: ", ERR_FILE)

