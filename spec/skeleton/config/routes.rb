Track::Routes.define do
  
  route '/',         TestController, :index,  :get
  route '/show/:id', TestController, :show,   :get
  route '/create',   TestController, :create, :post
  route '/update',   TestController, :update, [:put, :post]
  route '/boom',     TestController, :boom
  route '/all',      TestController, :index
  
end
