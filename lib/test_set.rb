require './test/lib/test_case.rb'

# A set of test cases, potentially containing other sets
# of test cases. The result is a tree of test cases, with
# this object being the root node.
class TestSet
  attr_accessor :target, :location, :tests, :test_count, :pass_count

  def initialize target, dir
    @target = target
    @location = dir

    # Scan the directory for test cases/sets, add them to the list,
    # and recursively count the number of cases.
    @test_count = 0
    @tests = []
    Dir.glob(@location+'/*').each do |t|
      if File.directory?(t)
        set = TestSet.new(@target, t)
        @test_count += set.test_count
        @tests << set
      else
        @tests << TestCase.new(@target, t)
        @test_count += 1
      end
    end

    # The total number of test cases that passed.
    @pass_count = 0
  end

  # Run all tests in this set, adding to `@pass_count` the number of
  # passed test cases that belong to this set. After all tests have been
  # run, `@pass_count` will contain the total number of test cases that
  # passed.
  # @return the number of passed test cases in this set.
  def run opts = {}
    @tests.each do |t|
      result = t.run(opts)

      case t
      when TestSet
        @pass_count += result
      when TestCase
        @pass_count += 1 if result
      end
    end

    @pass_count
  end

  # Print the results for each test in the set, as well as the set name.
  # `level` is the indentation level for this set, and `indent` is the
  # string used for indentation.
  def print level = 0, indent = '   '
    # Print the set name only for subsets. The name of the set
    # is the name of the lowest directory of @location.
    name = @location.split('/')[-1].tr('_', ' ')
    puts indent*level + name if level > 0

    # Print subtests
    @tests.each{ |t| t.print(level+1) }
  end
end
