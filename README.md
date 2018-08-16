# VerifyRedirects - Verify HTTP redirects

Verify HTTP redirects - comes with CLI and CSV support (you can of course use plain Ruby too).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'verify_redirects'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install verify_redirects

## CLI usage

```
Usage: verify_redirects --help
        --input=val0                 CSV file path (required) - must be a file with two columns: from_url, to_url (order doesn't matter)
        --output=val0                CSV output path (optional)
        --[no-]debug                 Print debug output (default: false)
    -h, --help                       How to use
```

## Ruby usage

Use the verifier directly
```ruby
verifier = Verifier.new

[
  # from_url, to_url
  %w[http://example.com/jacobburenstam https://jacobburenstam.com/]
  # ...
].each do |data|
  from, to = data
  result = verifier.call(from, to)

  result.success # => false
  result.start_url # => 'http://example.com/jacobburenstam'
  result.expected_redirect # => 'https://jacobburenstam.com/'
  result.redirected_to # => nil
end

verifier.results.length # => 1
```

From CSV-files

```ruby
input_path = '/tmp/in.csv'
output_path = '/tmp/out.csv'
# create demo data
File.write(input_path, <<~CSV
  from_url,to_url
  http://jacobburenstam.com/,https://jacobburenstam.com/
  http://example.com/,https://google.com/
CSV
)

# input_path - must be a CSV file with two columns: from_url, to_url (order doesn't matter)
VerifyRedirects.from_csv(input_path: input_path, output_path: output_path) do |result|
  unless result.success
    puts "Failed redirect for #{result.start_url}"
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buren/verify_redirects.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).
