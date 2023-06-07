require 'rails_helper'

RSpec.describe 'SportsController', type: :request do
  describe 'GET #index' do
    let(:sports_data) do
      [
        {'id'=> 1, 'desc'=> 'FootBall', 'pos'=> 2, 'hasInplayEvents'=> true, 'hasUpcomingEvents'=> true, 'comp'=> []}, 
        {'id'=> 2, 'desc'=> 'Tennis', 'pos'=> 1, 'hasInplayEvents'=> true, 'hasUpcomingEvents'=> false, 'comp'=> [1, 2]}
      ]      
    end

    before do
      allow_any_instance_of(ApiClients::SportsEventsClient).to receive(:sports_data).and_return(sports_data)
    end

    context 'when the request is successful' do
      it 'renders the index template' do
        get sports_path
        expect(response).to render_template(:index)
      end

      it 'renders json when a .json call is made' do
        get ('/sports.json')
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq([
          {"id"=>2, "title"=>"Tennis", "hasInplayEvents"=>"Yes", "hasUpcomingEvents"=>"N/A", "comp_size"=>2},
          {"id"=>1, "title"=>"FootBall", "hasInplayEvents"=>"Yes", "hasUpcomingEvents"=>"Yes", "comp_size"=>0}          
        ])              
      end

      it 'assigns the sorted and transformed data to @sports' do 
        get sports_path
        expect(assigns(:sports)).to eq([
          {:id=>2, :title=>"Tennis", :hasInplayEvents=>"Yes", :hasUpcomingEvents=>"N/A", :comp_size=>2},
          {:id=>1, :title=>"FootBall", :hasInplayEvents=>"Yes", :hasUpcomingEvents=>"Yes", :comp_size=>0}          
        ])
      end
    end

    context 'when request causes some error' do 
      let(:error_response) do 
        {
          error: {
            code: 500,
            message: 'Internal Server Error.'
          }
        }
      end

      before do
        allow_any_instance_of(ApiClients::SportsEventsClient).to receive(:sports_data).and_return(error_response)
      end

      it 'renders the error template' do 
        get '/sports'
        expect(response).to render_template('common/_error')        
      end

      it 'assigns the error code and message to @error_code and @error_message' do
        get '/sports'
        expect(assigns(:error_code)).to eq(500)
        expect(assigns(:error_message)).to eq('Internal Server Error.')
      end

    end

  end
end