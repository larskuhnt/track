require 'rack'
require 'track/application'
require 'track/routes'
require 'track/controller'

module Track
  
  @@responses = {
    :routing_error => [404, { 'Content-Type' => 'text/plain'}, ['Route not found']],
    :not_found     => [404, { 'Content-Type' => 'text/plain'}, ['Resource not found']]
  }
  @@env     = ENV['RACK_ENV'].to_sym.freeze
  @@config  = nil
  @@root    = nil
  @@plugins = []
  
  class << self
    def boot!(root)
      @@root   = root
      @@config = load_config_file!(:config)
      boot_plugins!
      Routes.load! File.join(root, 'config', 'routes')
    end
  
    def [](key)
      @@config[key.to_s]
    end
    
    def config
      @@config
    end
    
    def env
      @@env
    end
    
    def env?(e)
      @@env == e.to_sym
    end
    
    def root
      @@root
    end
  
    def version
      VERSION
    end
    
    def plugin(plugin)
      @@plugins << plugin
    end
    
    def responses
      @@responses
    end
    
    def load_config_file!(filename)
      YAML.load(File.open(File.join(root, 'config', "#{filename}.yml")))[env.to_s]
    end
    
    def boot_plugins!
      @@plugins.each { |plugin| plugin.boot! }
    end
  end
end
