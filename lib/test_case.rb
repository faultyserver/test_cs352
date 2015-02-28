require 'open3'
require 'yaml'

class TestCase
  attr_accessor :target, :file, :name, :input, :expected, :output, :result

  def initialize target, file_name
    @target = target
    @file = file_name

    # Extract the test name
    @name = @file.split('/')[-1].sub(/^(err_)*test_/, '').tr('_', ' ')

    # Read in the test case
    test_params = YAML.load_file @file
    @input    = test_params["input"]
    @expected = test_params["output"] || "" # If the output should be empty, ensure a string exists
    # # Ignore blank lines
    # @expected.gsub!(/^$\n/, '')
    # # Ignore the last newline (inserted by |+ in YAML)
    @expected.chomp!
  end

  # Run the test and store the result.
  # @return `true` if the test passed, `false` otherwise.
  def run opts = {}
    # Create a temporary file with just the test input
    test_input = File.new('/tmp/'+@name, File::CREAT|File::TRUNC|File::RDWR)
    test_input.write(@input)
    test_input.close

    # Run the test and capture all output along with the status code.
    @output, status = Open3.capture2e("#{@target} \"#{test_input.path}\"")
    @output.chomp!
    # @output.gsub! /^$\n/, ''

    # Delete the temporary file
    File.unlink(test_input.path)

    # Determine if the test passed.
    @result = @output == @expected

    # Log any failures
    if @result == false
      tabbed_expected = @expected.gsub("\n", "\n\t\t")
      tabbed_got = @output.gsub("\n", "\n\t\t")
      $log.puts("\"#{@name}\" failed:\n")
      $log.puts("\tTest location: #{@file}\n")
      $log.puts("\tExpected:\n\t\t#{tabbed_expected}\n")
      $log.puts("\tGot:\n\t\t#{tabbed_got}\n")
      $log.puts("<end>\n\n")
    end

    @result
  end

  # Print out the name of the test case, colorized based on whether or
  # not it passed.
  def print level = 0, indent = '   '
    result_text = @name
    if @result
      result_text.green!
    else
      result_text.red!
    end

    puts indent*level + result_text
  end
end
