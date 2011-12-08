require 'active_record'

module Track
  module DB
    
    @@config = nil
    
    class << self
      
      def [](key)
        @@config[key.to_s]
      end
      
      def connected?
        ActiveRecord::Base.connected?
      end
      
      def connect!
        @@config = Track.load_config_file!('database') if @@config.nil?
        unless connected?
          ActiveRecord::Base.establish_connection(@@config)
          ActiveRecord::Base.connection
        end
      end
    
    end
    
  end
end
