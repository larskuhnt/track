# Track

A nano framework for server applications based on rack and ruby 1.9 named capture groups.

## What Track does

- modularize your rack app through controllers
- routes paths to methods of controllers via `Track::Routes.define` in `config/routes.rb`
- define before and after filters

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
  
  before_filter :find_user, :only => :show
  
  def index
    [200, { "Content-Type" => 'text/plain' }, ['hello from index']]
  end
  
  def show
    [200, { "Content-Type" => 'text/plain' }, [@user.name]]
  end
  
  private
  
  def find_user
    @user = User.find(params['id'])
    respond [404, { "Content-Type" => 'text/plain' }, ['user not found']] unless @user
  end
end
```

You can build arbitrary path match patterns by using regaular expressions.

The `before_filter` and `after_filter` methods are similar to the ActionController filter methods. If `fail` is called in a before_filter the action will not get called and the given response will be returned.

## Plugins

Currently available:

* ActiveRecord
* Sequel

Go to the [track-plugins](http://www.github.com/larskuhnt/track-plugins) project for more details.

## Author

[Lars Kuhnt](http://www.github.com/larskuhnt)
Copyright (c) 2011

## License

Published under the MIT License.

See [LICENSE](LICENSE) for details.
