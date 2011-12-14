# encoding: utf-8
require 'spec_helper'

describe Track::Routes, '#load!' do
  
  it "should not raise an error" do
    lambda {
      Track::Routes.load!(File.join(SKELETON_ROOT, 'config', 'routes'))
    }.should_not raise_error
  end
  
end

describe Track::Routes do
  
  before do
    Track::Routes.define do
      add '/array',      TestController, :size
      add '/string/:id', ApplicationController, :downcase, :post
    end
  end
  
  it "should find the route for /" do
    route = Track::Routes.find('GET', '/array')
    route[:class].should == TestController
    route[:action].should == :size
  end
  
  it "should find the route for /test/1" do
    route = Track::Routes.find('POST', '/string/1')
    route[:class].should == ApplicationController
    route[:action].should == :downcase
  end
  
  it "should not find a route if the wrong request method is given" do
    route = Track::Routes.find('GET', '/test/1')
    route.should be_nil
  end
  
end
