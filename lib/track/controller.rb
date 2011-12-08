# encoding: utf-8
require_relative 'route_map'
require_relative 'filter_map'

module Track
  class Controller
    
    @@route_map  = RouteMap.new
    @@filter_map = FilterMap.new
    
    attr_accessor :params
    
    def initialize
      @params = {}
    end
    
    def call(env)
      req = Rack::Request.new(env)
      @params.merge!(req.params)
      if route = @@route_map.scan(self.class.name, req)
        @params.merge!(route[:matches])
        response_for(route)
      else
        routing_error
      end
    end
    
    protected
    
    def routing_error
      [404, { 'Content-Type' => 'text/plain' }, ['route not found']]
    end
    
    def response_for(route)
      if filters = @@filter_map.scan(self.class.name, route[:action])
        filters.each do |m|
          send(m)
          return @_response if @_response
        end
      end
      send(route[:action])
    end
    
    def fail(response = [404, { 'Content-Type' => 'text/plain' }, ['']])
      @_response = response
    end
    
    def self.route(pattern, action, methods = nil)
      @@route_map.add self.name, pattern, action, methods
    end
    
    def self.pre(method, actions)
      @@filter_map.add self.name, method, actions
    end
  
  end
end
