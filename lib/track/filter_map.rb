# encoding: utf-8

module Track
  class FilterMap < Hash
    
    def add(clazz, action, method)
      self[clazz] ||= {}
      self[clazz][action.to_sym] ||= []
      self[clazz][action.to_sym] << method.to_sym
    end
    
    def scan(clazz, action)
      self[clazz] && self[clazz][action.to_sym] ? self[clazz][action.to_sym] : nil
    end
    
  end
end
