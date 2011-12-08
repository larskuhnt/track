# encoding: utf-8
require 'spec_helper'

describe Track::FilterMap do
  
  before do
    @map = Track::FilterMap.new
  end
  
  context '#add' do
    
    it "should set the method for one specific action" do
      @map.add('Test', :method, :action)
      @map['Test'][:action].should == [:method]
    end
    
    it "should set the method for many actions" do
      @map.add('Test', :method, [:action1, :action2])
      @map['Test'][:action1].should == [:method]
      @map['Test'][:action2].should == [:method]
    end
    
  end
  
  context '#scan' do
    
    before do
      @map = Track::FilterMap.new
    end
    
    it "should include the methods specifically defined for the action" do
      @map.add('Test', :method, :action)
      @map.scan('Test', :action).should == [:method]
    end
    
    it "should only include the methods for the correct key" do
      @map.add('Test', :method, :action)
      @map.scan('Test1', :action).should == []
    end
    
    it "should not include the method for another action" do
      @map.add('Test', :method, :action)
      @map.scan('Test', :action1).should == []
    end
    
    it "should include the method for all actions it is defined for" do
      @map.add('Test', :method, [:action1, :action2])
      @map.scan('Test', :action1).should == [:method]
      @map.scan('Test', :action2).should == [:method]
    end
    
    it "should include all methods defined for the action" do
      @map.add('Test', :method1, [:action1, :action2])
      @map.add('Test', :method2, :action1)
      @map.add('Test', :method3, :action2)
      @map.scan('Test', :action1).should == [:method1, :method2]
      @map.scan('Test', :action2).should == [:method1, :method3]
    end
    
  end
  
end
