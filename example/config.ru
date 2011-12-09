require File.join(File.expand_path('..', __FILE__), 'application')

app = Rack::Builder.new do
  map '/' do
    run ApplicationController.new
  end
end
run app