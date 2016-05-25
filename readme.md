# Refinery CMS Api

[![Build Status](https://travis-ci.org/refinerycms-contrib/refinerycms-api.svg?branch=master)](https://travis-ci.org/refinerycms-contrib/refinerycms-api)

This extension allows you to use a Rest API with Refinery CMS 3.0 and later.

## TODO
* [ ] Check Abilities
* [ ] Fix specs
* [ ] Check how to generate API key (create a rake task)

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
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/pages
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/pages/1
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/pages/new

$ curl -X POST --header "X-Refinery-Token: YOUR_API_TOKEN" "http://localhost:3000/api/v1/pages" -d 'page[title]=test'
$ curl -X PUT --header "X-Refinery-Token: YOUR_API_TOKEN" "http://localhost:3000/api/v1/pages/1" -d 'page[title]=test2'
$ curl -X DELETE -H "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/pages/1
curl -X DELETE -H "X-Refinery-Token: 123" http://localhost:3000/api/v1/pages/1
```

### Images

```ruby
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/images
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/images/1
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/images/new
```

### Resources

```ruby
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/resources
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/resources/1
$ curl --header "X-Refinery-Token: YOUR_API_TOKEN" http://localhost:3000/api/v1/resources/new
```

## Contributing

Please see the [contributing.md](contributing.md) file for instructions.
