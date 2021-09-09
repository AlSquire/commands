require "test_helper"
require "readline"
require "mocha/minitest"

class CommandsTest < Minitest::Test
  def teardown
    FileUtils.remove_file 'commands.yml' if File.exist? 'commands.yml'
  end

  def test_that_it_has_a_version_number
    refute_nil ::Commands::VERSION
  end

  def test_it_output_helps_when_no_commands_yml
    out, _ = capture_subprocess_io do
      load './exe/commands'
    end

    assert_match "Example of commands.yml", out
  end

  def test_it_outputs_interactive_menu_when_commands_yml_is_present
    FileUtils.cp './test/commands.sample.yml', 'commands.yml'

    Readline.expects(:readline).returns('')
    out, _ = capture_subprocess_io do
      load './exe/commands'
    end

    assert_match "Enter a number or alias followed by optional args, nothing to exit", out
  end
end
