require 'spec_helper'

describe RegionController do

  before :all do
    @region = Factory.create(:region)
  end

  describe 'GET #show' do
    before do
      get :show, id: @region
    end

    it 'assigns region for the view' do
      assigns(:region).should == @region
    end

    it { should render_template(:show) }
  end

  describe "GET #new" do
    before do
      login_user
      Region.stub(:new).and_return(@region)
      Region.stub(:find).and_return(@region)
    end

    it "is successful" do
      get :new
      response.should be_success
    end

    it "renders new template" do
      get :new
      response.should render_template('new')
    end

    it "creates a new region" do
      Region.should_receive(:new).and_return(@region)
      get :new
    end

    it "does not save the new region" do
      @region.should_not_receive(:save)
      get :new
    end

    it "assigns the new region for the view" do
      get :new
      assigns[:region].should equal(@region)
    end

    it "is not successful when not logged in" do
      logout_user
      get :new
      response.should_not be_success
    end
  end

  describe "POST #create" do
    before do
      @valid_attributes = Factory.attributes_for(:region)
      @invalid_attributes = Factory.attributes_for(:region, name: '')
      login_user
      Region.stub(:new).and_return(@region)
      Region.stub(:find).and_return(@region)
      @region.stub(:save).and_return(true)
      @region.stub(:encode_region_area).and_return(true)
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    it "creates a new region" do
      Region.should_receive(:new).and_return(@region)
      @region.should_receive(:save).and_return(true)
      post :create, :region => @valid_attributes
    end

    it "redirects to the show page if save successful" do
      post :create, :region => @valid_attributes
      response.should redirect_to("http://test.host/region/show/#{@region.id}")
    end

    it "renders new template if save unsuccessful" do
      Region.should_receive(:new).and_return(@region)
      @region.should_receive(:save).and_return(false)
      post :create, :region => @invalid_attributes
      response.should render_template('new')
    end
  end

  describe "GET #edit" do
    before do
      @region = Factory.build(:region, id: '1')
      Region.stub(:find).and_return(@region)
      login_user
    end

    def do_get
      get :edit, id: "1"
    end

    it "is successful" do
      do_get
      response.should be_success
    end

    it "renders edit template" do
      do_get
      response.should render_template('edit')
    end

    it "finds the region requested" do
      Region.should_receive(:find).and_return(@region)
      do_get
    end

    it "should assign the found Track for the view" do
      do_get
      assigns[:region].should equal(@region)
    end
  end

  describe  "PUT #update" do
    before do
      @region = Factory.build(:region, id: '1', description: '')
      @region.stub(:encode_region_area).and_return(true)
      Region.stub(:find).and_return(@region)
      login_user
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    def put_with_successful_update
      @region.stub(:update_attributes).and_return(true)
      post :update, id: '1', :region => { description: '' }
    end

    def put_with_failed_update
      @region.stub(:update_attributes).and_return(false)
      post :update, id: '1', :region => { description: '' }
    end

    it "finds the region requested" do
      Region.should_receive(:find).and_return(@region)
      put_with_successful_update
    end

    it "assigns the found region for the view" do
      put_with_successful_update
      assigns(:region).should equal(@region)
    end

    it "redirects to the region page on successful update" do
      put_with_successful_update
      response.should redirect_to("http://test.host/region/show/#{@region.id}")
    end

    it "re-renders 'edit' on failed update" do
      put_with_failed_update
      response.should render_template('edit')
    end
  end

end