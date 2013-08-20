require 'spec_helper'

describe FaqController do
  describe  'handling GET /' do
    before do
    end

    def do_get
      get :index
    end

    it 'Should render the list template' do
      do_get
      response.should render_template('list')
    end
  end
end