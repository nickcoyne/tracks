require 'spec_helper'

describe AccountController do
  before :all do
    @user = Factory.build(:user)
  end

  describe 'GET #signup' do
    before do
      User.stub(:new).and_return(@user)
      User.stub(:find).and_return(@user)
    end

    it "is successful" do
      get :signup
      response.should be_success
    end

    it "renders edit template" do
      get :signup
      response.should render_template('signup')
    end

    it "creates a new user" do
      User.should_receive(:new).and_return(@user)
      get :signup
    end

    it "does not save the new user" do
      @user.should_not_receive(:save)
      get :signup
    end

    it "assigns the new user for the view" do
      get :signup
      assigns[:user].should equal(@user)
    end
  end
end