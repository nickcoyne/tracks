require 'spec_helper'

describe Area do
  describe "creating an area" do
    it "should require compulsory fields" do
      area = Factory.build(:area, :name => nil, :description => nil)
      area.save.should == false
      area.should have(3).errors_on(:name)
      area.should have(1).error_on(:description)
    end
  end
end