require "commands/version"

# module Commands
#   class Error < StandardError; end
#   # Your code goes here...
# end

# TODO: stdin and stdout for shell compatibility (useful?)
require 'readline'
require 'yaml'

# Check for commands.yml in current working  directory
file = File.read('commands.yml') rescue nil

# If command contains %{argX}, replace it with the Xth argument
# Otherwise, all arguments are put at the end of command
def resolve_command_line(command, args)
  if command.match(/%\{arg\d+\}/)
    hashed_args = {}
    args.each.with_index do |arg, index|
      hashed_args["arg#{index + 1}".to_sym] = arg
    end

    command % hashed_args
  else
    [command, args] * ' '
  end
end

if file
  commands = YAML.load(file)

  input, *args = ARGV

  if !input
    # Display commands
    commands.each.with_index do |command, index|
      puts
      puts "#{index + 1}/ #{command['desc']}"
      puts "=> #{command['command']}"
      puts "- alias: #{command['alias']}" if command['alias']
    end

    puts
    puts "Enter a number or alias followed by optional args, nothing to exit"
    puts

    prompt = "> "
    input, *args = Readline.readline(prompt, true).split(' ')
  end

  if input && input != ""
    command = if input.match? /^[1-9][0-9]*$/
      commands[input.to_i - 1]
    else 
      commands.detect do |c|
        c['alias'] && c['alias'] == input
      end
    end

    if command
      command_line = resolve_command_line(command['command'], args)
    
      puts " => #{command_line}"
      system(command_line)
    else
      puts "No command found for #{input}"
    end
  end
else
  puts "commands.yml not found in current directory"
  puts
  puts "Example of commands.yml:"
  puts %Q{
    -
      desc: "Rails server"
      command: "bundle exec rails server"
      alias: "rs"
    -
      desc: "Webpack dev server"
      command: "./bin/webpack-dev-server"
      alias: "ws"
    -
      desc: "Some reversed ordered arguments"
      command: "echo %{arg3} %{arg2} %{arg1}"
  }
end