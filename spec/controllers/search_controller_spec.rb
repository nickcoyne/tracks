require 'spec_helper'

describe SearchController do
  describe  'handling GET /' do
    before do
    end

    def do_get
      get :index
    end

    it 'Should render the index template' do
      do_get
      response.should render_template('index')
    end
  end
end