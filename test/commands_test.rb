require "test_helper"

class CommandsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Commands::VERSION
  end

  def test_it_output_helps_when_no_commands_yml
    out, err = capture_io do
      load './exe/commands'
    end

    assert_match /Example of commands.yml/, out
  end
end
