require 'spec_helper'

describe User do
  it "randomly assigns control_group to false on create" do
    user = Factory.build :user
    Kernel.should_receive(:rand).and_return(0.49)
    user.save
    user.control_group.should be_false
  end

  it "randomly assigns control_group to true on create" do
    user = Factory.build :user
    Kernel.should_receive(:rand).and_return(0.5)
    user.save
    user.control_group.should be_true
  end

  it "does not affect control_group on save existing" do
    user = Factory :user
    Kernel.should_receive(:rand).never
    user.save
  end
end
