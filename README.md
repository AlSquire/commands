# Commands

Have a simple cheatsheet AND a quick launch by project.
Installing this gem adds a `commands` executable displaying a menu of commands defined in `./commands.yml` in the current directory.

## Installation

    $ gem install al-commands

## Usage

Create a `commands.yml` file in a directory, example:

```yaml
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
```

Then typing...

    $ commands

...will display a menu with a prompt:

```
1/ Rails server
=> bundle exec rails server
- alias: rs

2/ Webpack dev server
=> ./bin/webpack-dev-server
- alias: ws

3/ Some reversed ordered arguments
=> echo %{arg3} %{arg2} %{arg1}

Enter a number or alias followed by optional args, nothing to exit

> 
```

Launch command by entering its number or alias, followed by args.

You can also launch directly without displaying menu:

    $ commands 2
    # => ./bin/webpack-dev-server 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AlSquire/commands.

