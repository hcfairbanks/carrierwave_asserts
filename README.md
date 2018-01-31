<!-- https://www.sitepoint.com/creating-your-first-gem/

Now in your main program you can just require your module and give it any file to parse. In Rails, we would probably put a module like this in the lib folder. You can create large module 'libraries' consisting of many nested modules and classes. Here is a more complex example module used for processing data.May 5, 2016

bundle gem carrierwave_asserts
add code
gem build carrierwave_asserts.gemspec
gem install carrierwave_asserts-0.1.0.gem
add this to a local rails Gemfile
gem 'carrierwave_asserts' -->


# Common issues
http://siawyoung.com/coding/ruby/invalid-gemspec.html


https://stackoverflow.com/questions/6256743/while-executing-gem-extconf-rb-are-not-files
I got this error because I hadn't commited my updates with git yet.

s.files         = `git ls-files`.split("\n")
That line is directly using git, and probably causing this error. Just do

git add .
git commit -a -m "init"


# CarrierwaveAsserts

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/carrierwave_asserts`. To experiment with that code, run `bin/console` for an interactive prompt.

Description here

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carrierwave_asserts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave_asserts

## Usage

Usage Instructions

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/carrierwave_asserts.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
