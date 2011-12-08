# encoding: utf-8

module Track
  class FilterMap < Hash
    
    def add(key, method, actions)
      self[key] ||= {}
      actions = actions.is_a?(Array) ? actions.map(&:to_sym) : [actions.to_sym]
      actions.each do |action|
        self[key][action.to_sym] ||= []
        self[key][action.to_sym] << method.to_sym
      end
    end
    
    def scan(key, action)
      if self[key]
        self[key][action.to_sym] ? self[key][action.to_sym] : []
      else
        []
      end
    end
    
  end
end
