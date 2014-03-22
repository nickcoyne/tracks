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

end