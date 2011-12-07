# encoding: utf-8
require 'spec_helper'

include Track

describe RouteMap, "#compile_regexp" do

  it "should create the correct regular expression without named parameters" do
    regex = /\A\/?\z/x
    RouteMap.new.send(:compile_regexp, '/').to_s.should == regex.to_s
  end
  
  it "should create the correct regular expression with named parameters" do
    regex = /\A\/(?<one> [^\/]+)\/(?<two> [^\/]+)\/?\z/x
    RouteMap.new.send(:compile_regexp, '/:one/:two/').to_s.should == regex.to_s
  end
  
  it "should match both parameters in /:one/:two/ for /match/me" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/:one/:two/')
    md[:one].should == 'match'
    md[:two].should == 'me'
  end
  
  it "should match both parameters in /:one/:two for /match/me without the trailing slash" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/:one/:two')
    md[:one].should == 'match'
    md[:two].should == 'me'
  end
  
  it "should match one parameter" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/match/:one/')
    md[:one].should == 'me'
  end
  
  it "should not match /match/me for /no_match/:one" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/hello/:one/')
    md.should be_nil
  end
  
  it "should not match /match/me for /" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/')
    md.should be_nil
  end
  
  it "should match '' for /" do
    md = "".match RouteMap.new.send(:compile_regexp, '/')
    md.should_not be_nil
  end
  
end
