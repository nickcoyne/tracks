require 'spec_helper'

describe TrackAkaController do
  before :all do
    @track_aka = Factory.create(:track_aka)
  end

  describe "GET #new" do
    before do
      login_user
      TrackAka.stub(:new).and_return(@track_aka)
      TrackAka.stub(:find).and_return(@track_aka)
    end

    it "is successful" do
      get :new
      response.should be_success
    end

    it "renders new template" do
      get :new
      response.should render_template('new')
    end

    it "creates a new track_aka" do
      TrackAka.should_receive(:new).and_return(@track_aka)
      get :new
    end

    it "does not save the new track_aka" do
      @track_aka.should_not_receive(:save)
      get :new
    end

    it "assigns the new track_aka for the view" do
      get :new
      assigns[:track_aka].should equal(@track_aka)
    end

    it "is not successful when not logged in" do
      logout_user
      get :new
      response.should_not be_success
    end
  end

  describe "POST #create" do
    before do
      @valid_attributes = Factory.attributes_for(:track_aka)
      @invalid_attributes = Factory.attributes_for(:track_aka, name: '')
      login_user
      TrackAka.stub(:new).and_return(@track_aka)
      TrackAka.stub(:find).and_return(@track_aka)
      @track_aka.stub(:save).and_return(true)
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    it "creates a new track_aka" do
      TrackAka.should_receive(:new).and_return(@track_aka)
      @track_aka.should_receive(:save).and_return(true)
      post :create, track_aka: @valid_attributes, track_id: @track_aka.track_id
    end

    it "redirects to the track edit page if save successful" do
      post :create, track_aka: @valid_attributes, track_id: @track_aka.track_id
      response.should redirect_to("http://test.host/track/edit/#{@track_aka.track_id}")
    end

    it "renders new template if save unsuccessful" do
      TrackAka.should_receive(:new).and_return(@track_aka)
      @track_aka.should_receive(:save).and_return(false)
      post :create, track_aka: @invalid_attributes, track_id: @track_aka.track_id
      response.should render_template('new')
    end
  end

  describe "POST #destroy" do
    before do
      @track_aka = mock_model(TrackAka, track_id: 99)
      @track = mock_model(Track, id: 99)
      @track_aka.stub(:track).and_return(@track)
      @track.stub(:updated_by=).and_return(true)
      @track.stub(:save).and_return(true)
      TrackAka.stub(:find).and_return(@track_aka)
      @track_aka.stub(:destroy).and_return(true)
      login_user
      controller.stub(:update_user_edit_stats).and_return(true)
    end

    def do_delete
      post :destroy, id: "1", track_id: "99"
    end

    it "finds the track_aka" do
      TrackAka.should_receive(:find).and_return(@track_aka)
      do_delete
      assigns[:track_aka].should == @track_aka
    end

    it "calls destroy on the found track_aka" do
      @track_aka.should_receive(:destroy)
      do_delete
    end

    it "redirects to the track edit page" do
      do_delete
      response.should redirect_to("http://test.host/track/edit/#{@track_aka.track_id}")
    end
  end
end