require 'open3'
require 'yaml'

class TestCase
  attr_accessor :target, :file, :name, :input, :expected, :output, :errors, :result

  def initialize target, file_name
    @target = target
    @file = file_name

    # Extract the test name
    @name = @file.split('/')[-1].sub(/^(err_)*test_/, '').tr('_', ' ')

    # Read in the test case
    test_params = YAML.load_file @file
    @input  = test_params["input"]
    @stdout = test_params["stdout"] || "" # If stdout should be empty, ensure a string exists
    @stderr = test_params["stderr"] || "" # If stderr should be empty, ensure a string exists

    # Ignore the last newline (inserted by |+ in YAML)
    @stdout.chomp!
    @stderr.chomp!
  end

  # Run the test and store the result.
  # @return `true` if the test passed, `false` otherwise.
  def run opts = {}
    # Create a temporary file with just the test input
    test_input = File.new('/tmp/'+@name, File::CREAT|File::TRUNC|File::RDWR)
    test_input.write(@input)
    test_input.close

    # Run the test and capture all output along with the status code.
    @output, @errors, status = Open3.capture3("#{@target} \"#{test_input.path}\"")

    # Delete the temporary file
    File.unlink(test_input.path)

    # Determine if the test passed. Both outputs must match exactly
    @result = @output == @stdout && @errors == @stderr

    # Log any failures
    if @result == false
      tabbed_exp_stdout = @stdout.gsub("\n", "\n\t\t\t")
      tabbed_exp_stderr = @stderr.gsub("\n", "\n\t\t\t")
      tabbed_got_stdout = @output.gsub("\n", "\n\t\t\t")
      tabbed_got_stderr = @errors.gsub("\n", "\n\t\t\t")
      $log.puts("\"#{@name}\" failed:\n")
      $log.puts("\tLocation: #{@file}\n")
      $log.puts("\tExpected:\n")
      $log.puts("\t\tstdout:\n\t\t\t#{tabbed_exp_stdout}")
      $log.puts("\t\tstderr:\n\t\t\t#{tabbed_exp_stderr}")
      $log.puts("\tGot:\n")
      $log.puts("\t\tstdout:\n\t\t\t#{tabbed_got_stdout}")
      $log.puts("\t\tstderr:\n\t\t\t#{tabbed_got_stderr}")
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
