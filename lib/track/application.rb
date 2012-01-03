# encoding: utf-8

module Track
  class Application
    
    def call(env)
      req = Rack::Request.new(env)
      if route = Routes.find(req.request_method, req.path_info)
        controller = route[:class].new(env, req.params.merge(route[:matches]))
        if response = controller.run_filters(:before, route[:action])
          return response
        else
          response = controller.send(route[:action])
          controller.run_filters(:after, route[:action])
          response
        end
      else
        Track.responses[:routing_error]
      end
    end
    
  end
end
