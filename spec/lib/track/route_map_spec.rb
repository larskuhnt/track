# encoding: utf-8
require 'spec_helper'

include Track

describe RouteMap, "#compile_regexp" do

  it "should create the correct regular expression without named parameters" do
    regex = /^\/?$/
    res = RouteMap.new.send(:compile_regexp, '/')
    res.first.to_s.should == regex.to_s
    res.last.should == []
  end
  
  it "should create the correct regular expression with named parameters" do
    regex = /^\/([^\/#\?]+)\/([^\/#\?]+)\/?$/
    res = RouteMap.new.send(:compile_regexp, '/:one/:two/')
    res.first.to_s.should == regex.to_s
    res.last.should == %w(one two)
  end
  
  it "should match both parameters in /:one/:two/ for /match/me" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/:one/:two/').first
    md[1].should == 'match'
    md[2].should == 'me'
  end
  
  it "should match both parameters in /:one/:two for /match/me without the trailing slash" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/:one/:two').first
    md[1].should == 'match'
    md[2].should == 'me'
  end
  
  it "should match one parameter" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/match/:one/').first
    md[1].should == 'me'
  end
  
  it "should not match /match/me for /no_match/:one" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/hello/:one/').first
    md.should be_nil
  end
  
  it "should not match /match/me for /" do
    md = "/match/me".match RouteMap.new.send(:compile_regexp, '/').first
    md.should be_nil
  end
  
  it "should match '' for /" do
    md = "".match RouteMap.new.send(:compile_regexp, '/').first
    md.should_not be_nil
  end
  
end

describe RouteMap, "#add and #scan" do
  
  before do
    @map = RouteMap.new
  end
  
  it "should return the matched route including the matches" do
    @map.add '/m/:one/:two/', TestController, :index, nil
    route = @map.scan('/m/1/2', :get)
    route[:matches]['one'].should == '1'
    route[:matches]['two'].should == '2'
    route[:action].should == :index
    route[:class].should == TestController
  end
  
  it "should return the route with a trailing slash" do
    @map.add '/m/:one/:two', TestController, :index, nil
    @map.scan('/m/1/2/', :get).should be_a(Hash)
  end
  
  it "should be false if no route is found" do
    @map.add '/m/:one/:two/', TestController, :index, nil
    @map.scan('/m/1/2/t', :get).should be_nil
  end
  
  it "should be false if the request method is not allowed" do
    @map.add '/m/:one/:two/', TestController, :index, :get
    @map.scan('/m/1/2', :post).should be_nil
  end
  
end

