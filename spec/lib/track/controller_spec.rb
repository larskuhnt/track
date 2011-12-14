# encoding: utf-8
require 'spec_helper'

describe  Track::Controller do
  
  before do
    @controller = TestController.new(:test => 'test')
  end
  
  describe '#run_filters' do
    
    context 'before #index' do
      
      it "should run #set_application_param" do
        @controller.should_receive(:set_application_param).once
        @controller.run_filters(:before, :index)
      end
      
      it "should run #set_test_param" do
        @controller.should_receive(:set_test_param).once
        @controller.run_filters(:before, :index)
      end
      
      it "should not run #set_show_action_param" do
        @controller.should_not_receive(:set_show_action_param)
        @controller.run_filters(:before, :index)
      end
      
      it "should not run #set_error_code_by_param" do
        @controller.should_not_receive(:set_error_code_by_param)
        @controller.run_filters(:before, :index)
      end
      
    end
    
    context 'before #show' do
      
      it "should run #set_application_param" do
        @controller.should_receive(:set_application_param).once
        @controller.run_filters(:before, :show)
      end
      
      it "should not run #set_test_param" do
        @controller.should_not_receive(:set_test_param)
        @controller.run_filters(:before, :show)
      end
      
      it "should run #set_show_action_param" do
        @controller.should_receive(:set_show_action_param).once
        @controller.run_filters(:before, :show)
      end
      
    end
  
  end
  
end
