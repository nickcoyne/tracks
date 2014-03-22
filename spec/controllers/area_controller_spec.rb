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

end