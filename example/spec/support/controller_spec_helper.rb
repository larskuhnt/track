module ControllerSpecHelper
  include Rack::Test::Methods
  
  def app
    Rack::Builder.new do
      map '/' do
        run ApplicationController.new
      end
    end
  end

end
