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

    # Delete the temporary file
    File.unlink(test_input.path)

    # Determine if the test passed. `rstrip` is to remove the lines added by `|+` in the YAML
    @result = @output.strip == @expected.strip

    # Log any failures
    if @result == false
      $log.puts("\"#{@name}\" failed:\n")
      $log.puts("Expected: \"#{@expected.strip}\"\n")
      $log.puts("Got: \"#{@output.strip}\"\n\n\n")
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
