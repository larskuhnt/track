# encoding: utf-8

module Track
  class FilterMap
    
    def initialize
      @filters = {}
    end
    
    def add(klass, kind, method, options = {})
      @filters[kind] ||= []
      @filters[kind] << [method, options, klass]
    end
    
    def scan(klass, kind, action)
      filters = []
      if @filters[kind]
        @filters[kind].each do |method, options, k|
          next if contains?(options[:except], action) || !(klass <= k)
          filters << method if contains?(options[:only], action) || blank?(options[:only])
        end
      end
      filters
    end
    
    private
    
    def contains?(a, k)
      a == k || (Array === a && a.include?(k)) ? true : false
    end
    
    def blank?(a)
      a.nil? || a.size == 0
    end
    
  end
end
