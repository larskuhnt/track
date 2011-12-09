# encoding: utf-8

class ApplicationController < Track::Controller
  
  route '/', :index
  
  def index
    [200, { "Content-Type" => "text/plain"}, StringIO.new('Hello from Track!')]
  end
  
  private
  
  def routing_error
    [404, { "Content-Type" => "text/plain"}, StringIO.new('Route not found')]
  end
  
end
