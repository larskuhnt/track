require 'rack'
require 'track/controller'

module Track
  
  @@env    = ENV['RACK_ENV'].to_sym.freeze
  @@config = nil
  @@root   = nil
  
  class << self
    def boot!(root)
      @@root   = root
      @@config = load_config_file!(:config)
      DB.connect! if defined?(DB)
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
    
    def load_config_file!(filename)
      begin
        YAML.load(File.open(File.join(root, 'config', "#{filename}.yml")))[env.to_s]
      rescue
        raise "Config file config/config.yml is missing!" if env?(:production)
        YAML.load(File.open(File.join(root, 'config', "#{filename}.example.yml")))[env.to_s]
      end
    end
  end
end
