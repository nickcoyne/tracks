require 'spec_helper'

describe AreaController do

  before :all do
    @area = Factory.create(:area)
  end

  describe 'GET #show' do
    before do
      get :show, id: @area
    end

    it 'assigns area for the view' do
      assigns(:area).should == @area
    end

    it { should render_template(:show) }
  end

  describe "GET #new" do
    before do
      login_user
      Area.stub(:new).and_return(@area)
      Area.stub(:find).and_return(@area)
    end

    it "is successful" do
      get :new
      response.should be_success
    end

    it "renders new template" do
      get :new
      response.should render_template('new')
    end

    it "creates a new area" do
      Area.should_receive(:new).and_return(@area)
      get :new
    end

    it "does not save the new area" do
      @area.should_not_receive(:save)
      get :new
    end

    it "assigns the new area for the view" do
      get :new
      assigns[:area].should equal(@area)
    end

    it "is not successful when not logged in" do
      logout_user
      get :new
      response.should_not be_success
    end
  end

  describe "POST #create" do
    before do
      @valid_attributes = Factory.attributes_for(:area)
      @invalid_attributes = Factory.attributes_for(:area, :name => '')
      login_user
      Area.stub(:new).and_return(@area)
      Area.stub(:find).and_return(@area)
      @area.stub(:save).and_return(true)
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    it "creates a new area" do
      Area.should_receive(:new).and_return(@area)
      @area.should_receive(:save).and_return(true)
      post :create, :area => @valid_attributes
    end

    it "redirects to the show page if save successful" do
      post :create, :area => @valid_attributes
      response.should redirect_to("http://test.host/area/show/#{@area.id}")
    end

    it "renders new template if save unsuccessful" do
      Area.should_receive(:new).and_return(@area)
      @area.should_receive(:save).and_return(false)
      post :create, :area => @invalid_attributes
      response.should render_template('new')
    end
  end

  describe "GET #edit" do
    before do
      @area = Factory.build(:area, :id => '1')
      Area.stub(:find).and_return(@area)
      login_user
    end

    def do_get
      get :edit, :id => "1"
    end

    it "is successful" do
      do_get
      response.should be_success
    end

    it "renders edit template" do
      do_get
      response.should render_template('edit')
    end

    it "finds the area requested" do
      Area.should_receive(:find).and_return(@area)
      do_get
    end

    it "should assign the found Area for the view" do
      do_get
      assigns[:area].should equal(@area)
    end
  end

  describe  "PUT #update" do
    before do
      @area = Factory.build(:area, :id => '1', :description => '')
      Area.stub(:find).and_return(@area)
      login_user
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    def put_with_successful_update
      @area.stub(:update_attributes).and_return(true)
      post :update, :id => '1', :area => { :description => '' }
    end

    def put_with_failed_update
      @area.stub(:update_attributes).and_return(false)
      post :update, :id => '1', :area => { :description => '' }
    end

    it "finds the area requested" do
      Area.should_receive(:find).and_return(@area)
      put_with_successful_update
    end

    it "assigns the found area for the view" do
      put_with_successful_update
      assigns(:area).should equal(@area)
    end

    it "redirects to the area page on successful update" do
      put_with_successful_update
      response.should redirect_to("http://test.host/area/show/#{@area.id}")
    end

    it "re-renders 'edit' on failed update" do
      put_with_failed_update
      response.should render_template('edit')
    end
  end
end