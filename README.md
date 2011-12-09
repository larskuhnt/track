# Track

A nano framework for server applications based on rack and ruby 1.9 named capture groups.

## What Track does

- modularize your rack app through controllers
- routes paths to methods inside of your controllers via the `route` method
- define before filters via the `pre` method
- ActiveRecord initializer through `require 'track/orm/active_record'`

## What Track does *not*

- support any template engines, your actions have to return low level rack responses

## Install

add the following to your Gemfile

`gem 'track'`

or install it via rubygems

`gem install track`

## Install example application

Clone the [http://github.com/larskuhnt/track-example](track-example) project:

```
git clone https://github.com/larskuhnt/track-example.git
```

or install it via the gem executable

```
track new my_track_project
```

## Usage

Subclass the `Track::Controller` class to define controllers:

### Example

```ruby
class UsersController < Track::Controller

  route '/',                      :index, :get
  route '/show/:id',              :show,  :get
  route '/update/(?<id> [^\/]+)', :show,  [:post, :put]
  
  pre :find_user, :show
  
  def index
    [200, { "Content-Type" => 'text/plain' }, StringIO.new('hello from index')]
  end
  
  def show
    [200, { "Content-Type" => 'text/plain' }, StringIO.new(@user.name)]
  end
  
  private
  
  def find_user
    @user = User.find(params['id'])
    fail [404, { "Content-Type" => 'text/plain' }, StringIO.new('user not found')] unless @user
  end
end
```

The `route` method maps a route to an action in your controller. You can define named parameters by appending a : or by using a named capture group.

You can build arbitrary path match patterns by using regaular expressions.

The `pre` method calls a method prior to the action. If `fail` is called in before filter method the action will not get called and the given response will be returned.

## Author

[Lars Kuhnt](http://www.github.com/larskuhnt)
Copyright (c) 2011

## License

Published under the MIT License.

See [LICENSE](LICENSE) for details.
