# Spine::Routing

[![Gem Version](https://badge.fury.io/rb/spine-routing.svg)](http://badge.fury.io/rb/spine-routing)
[![Dependency Status](https://gemnasium.com/rspine/routing.svg)](https://gemnasium.com/rspine/routing)
[![Code Climate](https://codeclimate.com/github/rspine/routing/badges/gpa.svg)](https://codeclimate.com/github/rspine/routing)
[ ![Codeship Status for rspine/routing](https://codeship.com/projects/f340c940-e121-0132-7351-0acdf541758b/status?branch=master)](https://codeship.com/projects/81073)

Router for Rack application. Supports scopes, path parameters and HTTP verbs
(GET, POST, PUT, PATCH, DELETE).

## Installation

To install it, add the gem to your Gemfile:

```ruby
gem 'spine-routing'
```

Then run `bundle`. If you're not using Bundler, just `gem install spine-routing`.

## Usage

```ruby
router = Spine::Routing::Router.new
router.configure do
  scope :users do
    get '', to: Users::List
    post ':id', to: Users::Add
  end

  get :status, to: -> (env) { [200, {}, []] }
end

router.call(env)
```
