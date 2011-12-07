# encoding: utf-8
require_relative 'route_map'
require_relative 'filter_map'

module Track
  class Application
  
    @@route_map  = RouteMap.new
    @@filter_map = FilterMap.new
  
    attr_accessor :params
  
    def initialize(routing_error_response = [404, { 'Content-Type' => 'text/plain' }, ['route not found']])
      @routing_error_response = routing_error_response
      @params = {}
    end
  
    def call(env)
      req = Rack::Request.new(env)
      @params.merge!(req.params)
      if route = @@route_map.scan(self.class.name, req)
        @params.merge!(route[:matches])
        response_for(route)
      else
        @routing_error_response
      end
    end
  
    protected
  
    def response_for(route)
      if filters = @@filter_map.scan(self.class.name, route[:action])
        filters.each do |m|
          response = send(m)
          return response if response
        end
      end
      send(route[:action])
    end
  
    def self.route(pattern, action, methods = nil)
      @@route_map.add self.name, pattern, action, methods
    end
  
    def self.before(action, method)
      @@filter_map.add self.name, action, method
    end
  
  end
end
