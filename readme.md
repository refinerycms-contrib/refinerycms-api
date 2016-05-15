# Refinery CMS Api

This extension allows you to use a Rest API with Refinery CMS 3.0 and later.

## TODO
* [ ] Add translated fields in JSON
* [ ] Improve Abilities
* [ ] Fix specs

## Installation

Simply put this in the Gemfile of your Refinery application:

```ruby
gem 'refinerycms-api', github: 'refinerycms-contrib/refinerycms-api', master: 'branch'
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

## Contributing

Please see the [contributing.md](contributing.md) file for instructions.
