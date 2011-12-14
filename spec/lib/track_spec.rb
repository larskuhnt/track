# encoding: utf-8
require 'spec_helper'

module Track::TestPlugin
  
  def self.boot!
  end
  
end

describe Track do
  
  describe "#boot!" do
    
    before do
      Track.boot!(SKELETON_ROOT)
    end
    
    it "should load the config.yml" do
      Track['test'].should == 'test'
    end

    it "should set the root correctly" do
      Track.root.should == File.expand_path('../../skeleton', __FILE__)
    end

    it "should set the env correctly" do
      Track.env?(:test).should be_true
      Track.env.should == :test
    end
    
  end
  
  describe 'plugin loading' do
    
    before do
      Track.plugin Track::TestPlugin
    end
    
    it "should TestPlugin should be booted" do
      Track::TestPlugin.should_receive(:boot!).once
      Track.boot!(SKELETON_ROOT)
    end
  end
  
end
