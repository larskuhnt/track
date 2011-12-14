# encoding: utf-8
require 'spec_helper'

class A < Track::Controller; end
class B < A; end

describe Track::FilterMap do
  
  before do
    @map = Track::FilterMap.new
  end
  
  it "should not raise an error if no routes are defined" do
    lambda {
      @map.scan(A, :before, :action)
    }.should_not raise_error
  end
  
  it "should include the method without only and except constrainsts" do
    @map.add(A, :before, :method)
    @map.scan(A, :before, :action).should == [:method]
  end
  
  it "should include the method of the superclass" do
    @map.add(A, :before, :method)
    @map.scan(B, :before, :action).should == [:method]
  end
  
  it "should not include the method of the subclass" do
    @map.add(B, :before, :method)
    @map.scan(A, :before, :action).should == []
  end
  
  it "should include the method if its set as only" do
    @map.add(A, :before, :method, :only => :action)
    @map.scan(A, :before, :action).should == [:method]
  end
  
  it "should include the method if its included in the only array" do
    @map.add(A, :before, :method1, :only => [:action1])
    @map.scan(A, :before, :action1).should == [:method1]
  end
  
  it "should not include the method if its set as except" do
    @map.add(A, :before, :method, :except => :action)
    @map.scan(A, :before, :action).should == []
  end
  
  it "should not include the method if its included in the except array" do
    @map.add(A, :before, :method1, :except => [:action1])
    @map.scan(A, :before, :action1).should == []
  end
  
  it "should not include the methods for another filter type" do
    @map.add(A, :before, :method, :only => :action)
    @map.scan(A, :after, :action).should == []
  end
  
  it "should not include the method if its not listed in the only array" do
    @map.add(A, :before, :method, :only => :action)
    @map.scan(A, :before, :action1).should == []
  end
  
  it "should include the method if its not set as except" do
    @map.add(A, :before, :method, :except => :action)
    @map.scan(A, :before, :action1).should == [:method]
  end
  
  it "should include the method if its not listed in the except array" do
    @map.add(A, :before, :method, :except => [:action])
    @map.scan(A, :before, :action1).should == [:method]
  end
  
  it "should include the method for all actions in the only array" do
    @map.add(A, :before, :method, :only => [:action1, :action2])
    @map.scan(A, :before, :action1).should == [:method]
    @map.scan(A, :before, :action2).should == [:method]
  end
  
  it "should be correct for a complex example" do
    @map.add(A, :before, :all)
    @map.add(A, :before, :only1, :only => :action1)
    @map.add(A, :before, :only2, :only => :action2)
    @map.add(A, :before, :except1, :except => :action1)
    @map.add(A, :before, :except1and3, :except => [:action1, :action3])
    
    @map.scan(A, :before, :action1).should == [:all, :only1]
    @map.scan(A, :before, :action2).should == [:all, :only2, :except1, :except1and3]
    @map.scan(A, :before, :action3).should == [:all, :except1]
    @map.scan(A, :before, :action4).should == [:all, :except1, :except1and3]
  end
  
end
