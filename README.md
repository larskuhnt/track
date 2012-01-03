# Track

A nano framework for server applications based on rack.

## What Track does

- modularize your rack app with controllers
- routes paths to methods of controllers via `Track::Routes.define` in `config/routes.rb`
- lets you define before- and after-filters in your controllers

## What Track does *not*

- support any template engines, your actions have to return low level rack responses
- no security layer

## Install

add the following to your Gemfile

`gem 'track'`

or install it via rubygems

`gem install track`

## Usage

Have a look at the example application. I will provide documentation and more examples in the future.

### Install example application

Clone the [http://github.com/larskuhnt/track-example](track-example) project:

```
git clone https://github.com/larskuhnt/track-example.git
```

or install it via the gem executable

```
track new my_track_project
```

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
