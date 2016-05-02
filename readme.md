# Refinery CMS Api

This extension allows you to use a Rest API with Refinery CMS 3.0 and later.

## Installation

Simply put this in the Gemfile of your Refinery application:

```ruby
gem 'refinerycms-api', '~> 1.0.0'
```

Then run `bundle install` to install it.


### Generate and run migrations

```sh
$ rails g refinery:api  # Generate initializer
$ rake db:migrate
```

Then restart your server.

## Usage

### Pages

```ruby
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/pages.json
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/pages/1.json
```

### Images

```ruby
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/images.json
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/images/1.json
```

### Resources

```ruby
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/resources.json
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/resources/1.json
```

## TODO
[ ] Add translated fields in JSON
[ ] Fix Abilities
[ ] Fix specs

## Contributing

Please see the [contributing.md](contributing.md) file for instructions.