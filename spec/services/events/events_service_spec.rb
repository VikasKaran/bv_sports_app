require 'rails_helper'

RSpec.describe Events::EventsService do 
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
	    	]}, 
	        {'id'=> 2, 'desc'=> 'Tennis', 'pos'=> 1, 'hasInplayEvents'=> true, 'hasUpcomingEvents'=> false, 'comp'=> [
	        	"events" => [{
	        	"id" => 1950147900,
				"desc" => "Elina Svitolina v Aryna Sabalenka",
				"scoreboard" => {
					"scrA" => 5,
					"scrB" => 2,
					"inPlay" => false
					},
				"markets" => [{
							"o" => [{
								"oid" => 12316846,
								"d" => "Mark",
								"pr" => "1/12",
								"keyDimension" => "HOME"
							}]
						}]
	        	}]
	        ]
	        }] 
	end

	describe 'get_events to return the events' do 
		context 'when sport exists' do
	      it 'returns the sport and events' do
	        sport_id = 1
	        expected_sport = {'id'=> 1, 'desc'=> 'FootBall', 'pos'=> 2, 'hasInplayEvents'=> true, 'hasUpcomingEvents'=> true, 'comp'=> [
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
	        sport, events = described_class.get_events(sports_data: sports_data, sport_id: sport_id)
	        expect(sport).to eq(expected_sport)
	        expect(events).not_to be_empty
	      end
    	end

    	context 'when sport does not exist' do
	      it 'returns empty sport and events' do
	        sport_id = 99

	        sport, events = described_class.get_events(sports_data: sports_data, sport_id: sport_id)

	        expect(sport).to be_nil
	        expect(events).to be_empty
	      end
    	end
	end

	describe 'get_outcomes to return outcomes' do 
		context 'when event exists' do 
	      it 'returns the event and outcomes' do
	        sport_id = 1
	        event_id = 15756810
	        expected_event = {
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
	        	}

	        event, outcomes = described_class.get_outcomes(sports_data: sports_data, sport_id: sport_id, event_id: event_id)
	        expect(event).to eq(expected_event)
	        expect(outcomes).not_to be_empty
	      end 
		end
		context 'when events do not exist' do
	      it 'returns empty event and outcomes' do
	        sport_id = 1
	        event_id = 99

	        event, outcomes = described_class.get_outcomes(sports_data: sports_data, sport_id: sport_id, event_id: event_id)

	        expect(event).to be_nil
	        expect(outcomes).to be_empty
	      end
    	end
	end
end