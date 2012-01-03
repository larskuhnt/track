# encoding: utf-8
require_relative 'filter_map'

module Track
  class Controller
    
    @@filters = FilterMap.new
    
    attr_reader :env, :params
    
    def initialize(env, params)
      @env    = env
      @params = params
    end
    
    def run_filters(kind, action)
      @@filters.scan(self.class, kind, action).each do |filter_method|
        self.send(filter_method)
        return @_response if @_response
      end
      nil
    end
    
    def respond(response)
      @_response = response
    end
    
    class << self
      
      def filters
        @@filters
      end
      
      def before_filter(method, options = {})
        @@filters.add(self, :before, method, options)
      end
      
      def after_filter(method, options = {})
        @@filters.add(self, :after, method, options)
      end
      
    end
    
  end
end
