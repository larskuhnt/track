
require 'track'

require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/test_controller'

Track.boot! File.expand_path('..', __FILE__)

