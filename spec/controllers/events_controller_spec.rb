require 'rails_helper'

RSpec.describe 'EventsController', type: :request do 
	describe 'GET #index for sports/:sport_id/events' do 
		let(:sports_data) do 
			[
	        {'id'=> 1, 'desc'=> 'FootBall', 'pos'=> 2, 'hasInplayEvents'=> true, 'hasUpcomingEvents'=> true, 'comp'=> [
	        	"events" => [{
	        	"id" => 15756810,
				"desc" => "Club Friendly",
				"scoreboard" => {
					"scrA" => 1,
					"scrB" => 0,
					"inPlay" => true
					}
	        	}]
	    	]}, 
	        {'id'=> 2, 'desc'=> 'Tennis', 'pos'=> 1, 'hasInplayEvents'=> true, 'hasUpcomingEvents'=> false, 'comp'=> [
	        	"events" => [{
	        	"id" => 1950147900,
				"desc" => "Elina Svitolina v Aryna Sabalenka",
				"scoreboard" => {
					"scrA" => 5,
					"scrB" => 2,
					"inPlay" => false
					}
	        	}]
	        ]
	        }] 
		end
		before do
        	allow_any_instance_of(ApiClients::SportsEventsClient).to receive(:sports_data).and_return(sports_data)
      	end

      	context 'when the API call is successful' do
      		it 'renders the index template' do 
      			get sport_events_path(sport_id:1)
      			expect(response).to render_template(:index)
      		end

      		it 'render JSON data for .json request' do 
      			get sport_events_path(sport_id: 1, format: :json)
      			expect(response).to have_http_status(200)
        		expect(response.content_type).to eq('application/json; charset=utf-8') 
      		end

      		it 'assigns the transformed data to @sport' do 
      			get sport_events_path(sport_id:1)
      			expect(assigns(:sport)).to eq({:id=>1, :title=>"FootBall", :hasInplayEvents=>"Yes", :hasUpcomingEvents=>"Yes", :comp_size=>1})
      		end

      		it 'assigns the transformed data to @events' do  
      			get sport_events_path(sport_id:2)
      			expect(assigns(:events)).to eq([
      			{
	        	:id => 1950147900,
				:title => "Elina Svitolina v Aryna Sabalenka",
				:scrA => 5,
				:scrB => 2,
				:inPlay => "No"
	        	}
      			])
      		end
      	end

      	context 'when the API call fails' do
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
      			get sport_events_path(sport_id:5) 
      			expect(response).to render_template('common/_error')
      		end

      		it 'assigns the value of @error_code and @erro_message' do
      			get sport_events_path(sport_id:2)
      			expect(assigns(:error_code)).to eq(500)
      			expect(assigns(:error_message)).to eq('Internal Server Error.')
      		end
      	end

	end

	describe 'GET #show for sport/:sport_id/event/:id' do 
			let(:sports_data) do 
				[
			        {'id'=> 1, 'comp'=> [
			        	"events" => [{
			        	"id" => 15756810,
						"desc" => "Club Friendly",
						"scoreboard" => {
							"scrA" => 1,
							"scrB" => 0,
							"inPlay" => true
							},
						"markets" => [{
							"o" => [{
								"oid" => 123168468809,
								"d" => "Elina Svitolina",
								"pr" => "12/5",
								"keyDimension" => "HOME"
							}]
						}]
			        	}]
			    	]}
	    		] 
			end

			before do
				allow_any_instance_of(ApiClients::SportsEventsClient).to receive(:sports_data).and_return(sports_data)
			end
			context 'when API call is successful' do 

				it 'returns show template' do 
					get sport_event_path(sport_id: 1, id: 15756810)
					expect(response).to render_template(:show)
				end

				it 'render JSON data for .json request' do 
	      			get sport_event_path(sport_id: 1, id: 15756810, format: :json)
	      			expect(response).to have_http_status(200)
	        		expect(response.content_type).to eq('application/json; charset=utf-8') 
      			end

      			it 'assigns the transformed data to @event' do  
	      			get sport_event_path(sport_id: 1, id: 15756810)
	      			expect(assigns(:event)).to eq({
		        	:id => 15756810,
					:title => "Club Friendly",
					:scrA => 1,
					:scrB => 0,
					:inPlay => "Yes"
		        	})
      			end

      			it 'assigns the transformed data to @outcomes' do  
	      			get sport_event_path(sport_id: 1, id: 15756810)
	      			expect(assigns(:outcomes)).to eq([{
		        	:id => 123168468809,
					:title => "Elina Svitolina",
					:pr => "12/5",
					:keyDimension => "HOME"
		        	}])
      			end

			end

			context 'when API call fails' do 
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
	      			get sport_event_path(sport_id: 1, id: 157568102) 
	      			expect(response).to render_template('common/_error')
	      		end

	      		it 'assigns the value of @error_code and @erro_message' do
	      			get sport_event_path(sport_id: 1, id: 157568102)
	      			expect(assigns(:error_code)).to eq(500)
	      			expect(assigns(:error_message)).to eq('Internal Server Error.')
	      		end
			end
	end
end