# encoding: utf-8

require 'track'
# require 'track/orm/active_record'
# require 'track/orm/sequel'

Track.boot! File.expand_path('..', __FILE__)

require_relative 'app/controllers/application_controller'
