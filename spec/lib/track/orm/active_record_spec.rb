# encoding: utf-8
require 'spec_helper'
require 'sqlite3'
require 'track/orm/active_record'

Track.boot!(SKELETON_ROOT)

describe Track::DB do
  
  it "should be connected to the database" do
    Track::DB.connected?.should be_true
  end
  
  it "should load the config" do
    Track::DB['adapter'].should == 'sqlite3'
    Track::DB[:database].should == ':memory:'
  end
  
end
