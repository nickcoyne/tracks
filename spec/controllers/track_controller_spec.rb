require 'spec_helper'

describe TrackController do

  before :all do
    @track = Factory.create(:track)
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

end