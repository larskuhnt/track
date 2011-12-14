
module Track
  class RouteMap
    
    def initialize
      @routes = []
    end
    
    def add(pattern, klass, action, methods = nil)
      raise "#{klass} is not a subclass of Track::Controller" unless klass <= Track::Controller
      methods = methods.is_a?(Array) ? methods : [methods] if methods
      regex, keys = compile_regexp(pattern)
      @routes.push(
        :pattern => regex,
        :keys    => keys,
        :class   => klass,
        :action  => action.to_sym,
        :methods => methods
      )
    end
    alias_method :route, :add
    
    def scan(path, method)
      @routes.each do |route|
        md = path.match(route[:pattern])
        if md && allowed_method?(route, method)
          keys = route[:keys]
          matches = {}
          (1..md.size-1).each { |i| matches[keys[i-1]] = md[i] }
          return route.merge(:matches => matches)
        end
      end
      nil
    end
    
    private
    
    def allowed_method?(route, method)
      route[:methods].nil? ? true : route[:methods].include?(method)
    end
    
    def compile_regexp(pattern)
      pattern = (pattern[-1,1] == '/' ? pattern.chop : pattern) << '/?'
      keys = []
      pattern.gsub!(/:(\w+)/) do |m|
        keys << $1
        '([^\/#\?]+)'
      end
      [Regexp.new("^#{pattern}$"), keys]
    end
  end
end
