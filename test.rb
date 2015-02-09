# test.rb
# - Jon Egeland, 2015
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



#####
### CONFIGURATION ###
#####

# The name of the program to test with
TESTER = './parser'

# The location of the tests. Used as a glob pattern.
TEST_DIR = './test/tests/*'

# The name of the file to log test results in.
# The file will be rewritten every time this tester is run.
ERR_FILE = 'test_errors.log'





#####
### SOURCE
#####

# Provides a way to read stdout and stderr.
require 'open3'

# Initial notification
version = 'CS 352 Project Test Script [v0.9] - Jon Egeland, 2015'
puts version
puts "\nSetup:"
puts "------"
puts "Tester:   #{TESTER}"
puts "Test dir: #{TEST_DIR}"



# Ensure the program exists
`make`

# Open the log file
log = File.open(ERR_FILE, 'w')



# Keep track of passed vs. total
test_count = pass_count = 0

# Run the tests
puts "\n\nTests:"
puts "------"
Dir.glob(TEST_DIR).each do |t|
  # Skips `.`, `..`, and any folders.
  # Needs to be changed to support complex file structures
  next unless File.file?(t)

  # Determine if the test is supposed to pass or fail
  should_fail = !!t.split('/')[-1][/^err_/]

  # Extract the test name
  name = t.split('/')[-1].sub(/^(err_)*test_/, '').tr('_', ' ')

  # Run the test
  Open3.popen3("#{TESTER} #{t}") do |cin, cout, cerr, cwait|
    # Get the output
    output = cerr.read
    failed = output != ''

    # Write any output to the log
    log.write("#{name}:\n#{output}\n\n") if failed

    # Determine whether or not it passed
    result = failed == should_fail ? 'passed' : 'FAILED'

    # Print the result
    puts "#{result}: #{name}"

    # Iterate the counters
    test_count+=1
    pass_count+=1 if result == 'passed'
  end
end

# Close the log file
log.close


# Final notification
puts "\n\nResults:"
puts "--------"
puts "#{pass_count}/#{test_count} tests passed."
puts "Errors have been logged in: #{ERR_FILE}"
