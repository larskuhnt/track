class TestController < ApplicationController
  
  before_filter :set_test_param, :except => [:show, :boom]
  before_filter :set_show_action_param, :only => :show
  before_filter :set_error_code_by_param, :only => :boom
  after_filter  :set_after_param
  
  def index
    build_response 'index'
  end
  
  def show
    build_response 'show'
  end
  
  def create
    build_response 'create'
  end
  
  def update
    build_response 'update'
  end
  
  def boom
    build_response 'boom'
  end
  
  private
  
  def set_error_code_by_param
    unless params['error_code'].nil?
      respond build_response('error', params['error_code'].to_i)
    end
  end
  
  def set_show_action_param
    params['action'] = 'show'
  end
  
  def set_test_param
    params['test'] = 'test'
  end
  
  def build_response(text, status = 200)
    [status, { 'Content-Type' => 'text/plain' }, [text]]
  end
  
  def set_after_param
    params['after'] = true
  end
  
end
