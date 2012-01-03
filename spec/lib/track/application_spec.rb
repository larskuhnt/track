# encoding: utf-8
require 'spec_helper'

describe Track::Application do
  include Rack::Test::Methods
  
  before :all do
    Track.boot! SKELETON_ROOT
    @app = Track::Application.new
  end
  
  def app
    @app
  end
  
  context 'GET /' do
  
    it "should return 'index' body" do
      get '/'
      last_response.body.should == 'index'
    end
  
    it "should return 404 for a post request" do
      post '/'
      last_response.status.should == 404
      last_response.body.should == 'Route not found'
    end
  
  end

  context 'GET /show' do
    
    it "should call the show action" do
      get '/show/123'
      last_response.body.should == 'show'
    end
  
    it "should return 404 if no id is given" do
      get '/show'
      last_response.status.should == 404
    end

    it "should return 404 if no id is given even with a trailing slash" do
      get '/show/'
      last_response.status.should == 404
    end
  
  end
  
  context 'PUT /update' do
    
    it "should return 404 for a GET request" do
      get '/update'
      last_response.status.should == 404
    end
    
    it "should return 200 for a POST request" do
      post '/update'
      last_response.status.should == 200
    end
    
    it "should return 200 for a PUT request" do
      put '/update'
      last_response.status.should == 200
    end

    it "should return 'update' body" do
      put '/update'
      last_response.body.should == 'update'
    end
    
  end

  context 'POST /create' do
  
    it "should return 404 for a GET request" do
      get '/create'
      last_response.status.should == 404
    end
  
    it "should return 404 for a DELETE request" do
      delete '/create'
      last_response.status.should == 404
    end
    
    it "should return 404 for a PUT request" do
      put '/create'
      last_response.status.should == 404
    end
  
    it "should return 200 for a POST request" do
      post '/create'
      last_response.status.should == 200
    end
  
    it "should return 200 for a POST request with trailing slash" do
      post '/create/'
      last_response.status.should == 200
    end
  
  end

  context '/all verbs test' do
  
    it "should return 200 for a POST request" do
      post '/all'
      last_response.status.should == 200
    end
  
    it "should return 200 for a GET request" do
      get '/all'
      last_response.status.should == 200
    end
  
    it "should return 200 for a PUT request" do
      put '/all'
      last_response.status.should == 200
    end
  
    it "should return 200 for a DELETE request" do
      delete '/all'
      last_response.status.should == 200
    end
  
  end
  
  context '/boom' do
  
    it "should return 200 if no error code is given" do
      get '/boom'
      last_response.status.should == 200
      last_response.body.should == 'boom'
    end
  
    it "should return 501 if 501 error code is given" do
      get '/boom', :error_code => 501
      last_response.status.should == 501
    end
  
  end
  
end