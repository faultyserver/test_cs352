# test.rb
# - Jon Egeland, 2015
#
# Test Script for CS 352, Project 1.
#
# This script runs a set of tests, passing them if they're output matches what is expected. Tests
# are defined in a YAML format, with the keys:
#   - input: A string representing the EXACT input that will be passed to the parser.
#   - output: A string representing the EXACT output should be expected from the parser.
#
# A NOTE ON OUTPUT: Leading and trailing whitespaces will be chomped (removed) before the values are
# compared. This allows for a looser definition both in the test definitions and in the parser itself.
# Take a look at the existing test cases for examples.
#
#
# Any files in the directory specified by `TEST_DIR` will be used as test cases. Be sure to not have
# any miscellaneous files in there, or else the script will likely fail.


#####
### CONFIGURATION ###
#####

# The name of the program to test with
TESTER = './parser'

# The location of the tests
TEST_DIR = './test/tests'

# The name of the file to log test results in
# The file will be rewritten every time this tester is run
ERR_FILE = 'test_failures.log'

# The name of the file where the results display will be kept.
# Access it at file://path/to/project/<RESULT_FILE>
RESULT_FILE = 'results.html'




#####
### SOURCE
#####

# Provides a way to read stdout and stderr.
require 'open3'
require 'yaml'
require './test/lib/test_set.rb'



# Add colorization methods to String
class String
  def colorize!(color_code); self.replace "\e[#{color_code}m#{self}\e[0m"; end
  def red!;    colorize!(31); end
  def green!;  colorize!(32); end
  def yellow!; colorize!(33); end
  def blue!;   colorize!(36); end
end



# Initial notification
version = 'CS 352 Project Test Script [Ruby v1.0] - Jon Egeland, 2015'
puts version
puts "\nSetup:"
puts "------"
puts "Tester:   #{TESTER}"
puts "Test dir: #{TEST_DIR}"



# Ensure the program exists
`make`



# Create the log file
$log = File.open(ERR_FILE, 'w')

# Create and run the test tree
tests = TestSet.new(TESTER, TEST_DIR)

puts "\n\nTests:"
puts "------"

passed = 0
total = 0
tests.each do |test|
  passed += 1 if test.run
  test.print

  total += 1
end

# Close the log
$log.close



# Determine the final results
passed_text = "#{passed}/#{total} tests passed."
ratio = total > 0 ? passed.to_f / total : 0
if ratio >= 1
  passed_text.green!
elsif ratio >= 0.8
  passed_text.yellow!
else
  passed_text.red!
end


# Final notification
puts "\n\nResults:"
puts "--------"
puts passed_text
puts "Errors have been logged in: " + "#{ERR_FILE}".blue!
puts "Test results available at: " + "file://#{Dir.getwd}/#{RESULT_FILE}".blue!






#
#
# CLEAN UP LATER
#
#

# Open the html file
@html = File.open(RESULT_FILE, 'w')

@html.write <<-END.gsub(/^ {2}/, '')
  <html>
  <head>
    <style type="text/css">
      body { background-color: #fff; font-family: 'Helvetica Neue', 'Arial', sans-serif; padding: 0; margin: 0; }
      ul.test-cases { list-style-type: none; margin: 0; padding: 0; width: 25%; height: 100%; overflow: scroll; background-color: #e7e7e7; }
      ul.test-cases li.test { text-decoration: none; padding: 10px 20px; border-bottom: 1px solid #ccc; font-size: 0.8em; }
      ul.test-cases li.test:hover { background-color: #d7d7d7; }
      .test .case.pass { color: #449D44; }
      .test .case.fail { color: #C9302C; }
      .test .case { font-size: 1.2em; }

      .muted { color: #999; }

      h1, h2, h3, h4, h5, h6 { margin: 0; padding: 0; }
      p { margin: 4px 0 0 0; line-height: 1.13em; }

      span.half-width {
        display: inline-block;
        width: 46%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <ul class="test-cases">
END

def write_html test_name, passed, output
  expected = true
  result = passed == expected ? 'pass' : 'fail'

  @html.write <<-END.gsub(/^ {4}/, '')
    <li class="test">
      <h2 class="case #{result.downcase}">#{test_name}</h2>
      <p>
        <span class="half-width">
          <span class="muted">expected:</span> <span class="expected">#{expected ? 'pass' : 'fail'}</span>
        </span>
        <span class="half-width">
        <span class="muted">got:</span> <span class="got">#{result.downcase}</span>
        </span>
      </p>
    </li>
  END
end

def end_html
  @html.write <<-END.gsub(/^ {4}/, '')
    </ul>
    </div>
    </body>
    </html>
  END
end

# Close the files
@html.close
