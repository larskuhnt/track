# encoding: utf-8
require 'spec_helper'

class TestApp < Track::Application
  
  route '/',         :index, :get
  route '/show/:id', :show,  :get
  route '/create',   :index, :post
  route '/all',      :index
  route '/boom',     :boom
  
  before :show, :set_action_param
  before :boom, :set_error_code_by_param
  
  def index
    [200, { 'Content-Type' => 'text/plain' }, ['index']]
  end
  
  def show
    [200, { 'Content-Type' => 'text/plain' }, ['show']]
  end
  
  def boom
    [200, { 'Content-Type' => 'text/plain' }, ['boom']]
  end
  
  def set_error_code_by_param
    params['error_code'] ? [params['error_code'].to_i, { 'Content-Type' => 'text/plain' }, ['error']] : nil
  end
  
  def set_action_param
    params[:action] = :show
    nil
  end
  
end

describe  Track::Application do
  include Rack::Test::Methods
  
  def app
    @app ||= TestApp.new
  end
  
  context 'GET /' do
    
    it "should return 'index' body" do
      get '/'
      last_response.body.should == 'index'
    end
    
    it "should return 404 for a post request" do
      post '/'
      last_response.status.should == 404
    end
    
  end
  
  context 'GET /show' do
    
    it "should have the id param set to 123" do
      get '/show/123'
      app.params['id'].should == '123'
    end
    
    it "should call the show action" do
      get '/show/123'
      last_response.body.should == 'show'
    end
    
    it "should include the query string params in the params hash" do
      get '/show/123?test=test'
      app.params['id'].should == '123'
      app.params['test'].should == 'test'
    end
    
    it "should include the get params in the params hash" do
      get '/show/123', { 'test' => 'test' }
      app.params['id'].should == '123'
      app.params['test'].should == 'test'
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
  
  context 'POST /create' do
    
    it "should return 404 for a GET request" do
      get '/create'
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
    
    it "should include the post params in the params hash" do
      post '/create', { 'test' => 'test' }
      app.params['test'].should == 'test'
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
    
  end
  
  
  context '/boom' do
    
    it "should return 200 and valid json if no error code is given" do
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
