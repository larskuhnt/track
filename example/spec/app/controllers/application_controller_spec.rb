# encoding: utf-8
require 'spec_helper'

describe ApplicationController do
  include ControllerSpecHelper
  
  it "should say 'Hello from Track!' for GET /" do
    get "/"
    last_response.body.should == 'Hello from Track!'
  end
  
  it "should return 404 for GET /boom" do
    get "/boom"
    last_response.status.should == 404
  end
  
end
