require 'spec_helper'

describe IndexController do
  describe  'handling GET /' do
    before do
    end

    def do_get
      get :index
    end

    it 'Should render the index template' do
      Nation.stub(:first).and_return(mock_model(Nation, id: 1))
      Region.stub(:all).and_return([mock_model(Region)])
      do_get
      response.should render_template('index')
    end
  end

end