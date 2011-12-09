# encoding: utf-8

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'

require_relative 'support/controller_spec_helper'

require File.join(File.expand_path('../..', __FILE__), 'application')
