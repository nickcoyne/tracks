require 'spec_helper'

describe TrackController do

  before :all do
    @track = Factory.create(:track)
  end

  describe 'GET #index' do
    before do
      Track.stub(:first).and_return(@track)
      get :index
    end

    it 'redirects to show the first track' do
      response.should redirect_to("http://test.host/track/show/#{@track.id}")
    end
  end

  describe 'GET #show' do
    before do
      get :show, id: @track
    end

    it 'assigns track for the view' do
      assigns(:track).should == @track
    end

    it { should render_template(:show) }
  end

  describe "GET #new" do
    before do
      login_user
      Track.stub(:new).and_return(@track)
      Track.stub(:find).and_return(@track)
    end

    it "is successful" do
      get :new
      response.should be_success
    end

    it "renders new template" do
      get :new
      response.should render_template('new')
    end

    it "creates a new track" do
      Track.should_receive(:new).and_return(@track)
      get :new
    end

    it "does not save the new track" do
      @track.should_not_receive(:save)
      get :new
    end

    it "assigns the new track for the view" do
      get :new
      assigns[:track].should equal(@track)
    end

    it "is not successful when not logged in" do
      logout_user
      get :new
      response.should_not be_success
    end
  end

  describe "POST #create" do
    before do
      @valid_attributes = Factory.attributes_for(:track)
      @invalid_attributes = Factory.attributes_for(:track, :name => '')
      login_user
      Track.stub(:new).and_return(@track)
      Track.stub(:find).and_return(@track)
      @track.stub(:save).and_return(true)
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    it "creates a new track" do
      Track.should_receive(:new).and_return(@track)
      @track.should_receive(:save).and_return(true)
      post :create, :track => @valid_attributes
    end

    it "redirects to the show page if save successful" do
      post :create, :track => @valid_attributes
      response.should redirect_to("http://test.host/track/show/#{@track.id}")
    end

    it "renders new template if save unsuccessful" do
      Track.should_receive(:new).and_return(@track)
      @track.should_receive(:save).and_return(false)
      post :create, :track => @invalid_attributes
      response.should render_template('new')
    end
  end

  describe "GET #edit" do
    before do
      @track = Factory.build(:track, :id => '1', :desc_overview => '', :desc_full => '', :desc_where => '', :desc_note => '')
      Track.stub(:find).and_return(@track)
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

    it "finds the track requested" do
      Track.should_receive(:find).and_return(@track)
      do_get
    end

    it "should assign the found Track for the view" do
      do_get
      assigns[:track].should equal(@track)
    end
  end

  describe  "PUT #update" do
    before do
      @track = Factory.build(:track, :id => '1', :desc_overview => '', :desc_full => '', :desc_where => '', :desc_note => '')
      Track.stub(:find).and_return(@track)
      login_user
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    def put_with_successful_update
      @track.stub(:update_attributes).and_return(true)
      post :update, :id => '1', :track => { :desc_overview => '', :desc_full => '', :desc_where => '', :desc_note => '' }
    end

    def put_with_failed_update
      @track.stub(:update_attributes).and_return(false)
      post :update, :id => '1', :track => { :desc_overview => '', :desc_full => '', :desc_where => '', :desc_note => '' }
    end

    it "finds the track requested" do
      Track.should_receive(:find).and_return(@track)
      put_with_successful_update
    end

    it "assigns the found track for the view" do
      put_with_successful_update
      assigns(:track).should equal(@track)
    end

    it "redirects to the track page on successful update" do
      put_with_successful_update
      response.should redirect_to("http://test.host/track/show/#{@track.id}")
    end

    it "re-renders 'edit' on failed update" do
      put_with_failed_update
      response.should render_template('edit')
    end
  end
end