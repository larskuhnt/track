# encoding: utf-8
lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

ENV['RACK_ENV'] = 'test'

require 'rack/test'

SKELETON_ROOT = File.expand_path('../skeleton/', __FILE__)
require File.join(SKELETON_ROOT, 'boot')
