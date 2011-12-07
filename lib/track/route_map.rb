# encoding: utf-8

module Track
  class RouteMap < Hash
    
    def add(clazz, pattern, action, methods)
      methods = methods.is_a?(Array) ? methods : [methods] if methods
      self[clazz] ||= []
      self[clazz].push(
        :pattern => compile_regexp(pattern),
        :action  => action.to_sym,
        :methods => methods
      )
    end
    
    def scan(clazz, req)
      method = req.request_method.downcase.to_sym
      self[clazz].each do |route|
        md = req.path_info.match(route[:pattern])
        return route.merge(:matches => match_hash(md)) if md && allowed_method?(route, method)
      end
      false
    end
    
    private
    
    def allowed_method?(route, method)
      route[:methods].nil? ? true : route[:methods].include?(method)
    end
    
    def match_hash(md)
      params = {}
      md.names.each do |key|
        params[key.to_s] = md[key]
      end
      params
    end
    
    def compile_regexp(pattern)
      pattern = (pattern[-1,1] == '/' ? pattern.chop : pattern) << '/?'
      pattern.gsub!(/:([^\/]+)/i, '(?<\1> [^/]+)')
      Regexp.new('\A'+pattern+'\z', Regexp::EXTENDED)
    end
  end
end
