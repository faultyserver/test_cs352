# test.rb
# - Jon Egeland, 2015
#
# Test Script for CS 352, Project 1.
#
# This script runs a set of tests, passing them if they're output matches what is expected. Tests
# are defined in a YAML format, with the keys:
#   - input: A string representing the EXACT input that will be passed to the parser.
#   - stdout: A string representing the EXACT output to STDOUT should be expected from the parser.
#   - stderr: A string representing the EXACT output to STDERR should be expected from the parser.
#
# Any files in the directory specified by `TEST_DIR` will be used as test cases. Be sure to not have
# any miscellaneous files in there, or else the script will likely fail.
#
# Adding tags is a good way to make testing faster. See the existing test cases for examples.

here = File.dirname(__FILE__)
require 'open3'
require 'optparse'
require 'yaml'
require here + '/lib/test_lib.rb'

# The default options for running the test script
runtime_options = {
  file: 'config.yaml',
  config: 'default',
  tags: []
}

# Allow overrides from the command line
OptionParser.new do |opts|
  opts.banner = "Usage: ruby test.rb [options]"


  opts.on('-f [FILE]', '--file [FILE]', 'The location of a configuration file') do |file|
    runtime_options[:file] = file
  end
  opts.on('-c [CONFIG]', '--config [CONFIG]', 'The name of the configuration to use') do |config|
    runtime_options[:config] = config
  end

  opts.on('-t [TAG]', '--tag [TAG]',
            'The name of a tag to include in the test suite.',
            'This will override the configuration file') do |tag|
    runtime_options[:tags] << tag
  end
end.parse!

config = YAML.load_file(here + '/' + runtime_options[:file])[runtime_options[:config]]
TESTER      = config["parser"]
TEST_DIR    = config["test_dir"]
TAGS        = runtime_options[:tags].empty? ? config["tags"] : runtime_options[:tags]
ERR_FILE    = config["error_log"]
RESULT_FILE = config["results_page"]

puts TAGS


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
tests = TestSet.new(TESTER, TEST_DIR, TAGS)

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
