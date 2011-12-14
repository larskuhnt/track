require_relative 'route_map'

module Track
  
  class Routes
    
    @@route_map = RouteMap.new
    
    class << self
      
      def load!(route_file)
        require route_file
      end
      
      def define(&block)
        @@route_map.instance_eval &block
      end
      
      def find(method, path)
        @@route_map.scan(path, method.downcase.to_sym)
      end
      
    end
    
  end
  
end
