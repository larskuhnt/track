# encoding: utf-8
require 'spec_helper'

Track.boot!(SKELETON_ROOT)

describe Track do
  
  it "should load the config.yml" do
    Track['test'].should == 'test'
  end
  
  it "should set the root correctly" do
    Track.root.should == File.expand_path('../../skeleton', __FILE__)
  end
  
  it "should set the env correctly" do
    Track.env?(:test).should be_true
    Track.env.should == :test
  end
  
end
