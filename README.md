# PrStatus

Simple ruby class to get the count of pull requests open. Internally uses the `Octokit` wrapper.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pr_status'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pr_status

## Usage

### Authentication
Pass in `access_token` or `login` and `password`.

```ruby
  # Access token (generated from github.com)
  client = PrStatus::Auth.new(access_token: '<40 char access token>').authenticate

  # Username/Password
  client = PrStatus::Auth.new(login: 'github_username', password: 'password').authenticate
```

### Getting pull request count
Returns the count of open and closed pull requests that have been opened by the authenticated user.
Defaults to searching from the first of the current month until today.
```ruby
  client.pull_requests
```

#### Filters
You can filter the range that the client will search for pull requests by `created_at` date.

```ruby
  client.pull_requests(range: 'monthly')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zsyed91/pr_status. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

