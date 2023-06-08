require 'rails_helper'

RSpec.describe 'SportTransformation' do 

	describe '.sport' do
		it 'transforms the input obj to a sport hash' do
			input = { 'id' => 1, 'desc' => 'Football', 'hasInplayEvents' => true, 'hasUpcomingEvents' => false, 'comp' => [] }
      		expected_output = { id: 1, title: 'Football', hasInplayEvents: 'Yes', hasUpcomingEvents: 'N/A', comp_size: 0 }
      		response = SportTransformation.sport(input)
      		expect(response).to eq(expected_output)
		end
	end

	describe '.sports' do 
		it 'transforms the input object array into an array of sport hashes' do
			input = [{ 'id' => 1, 'desc' => 'Football', 'hasInplayEvents' => true, 'hasUpcomingEvents' => false, 'comp' => [] },
					 { 'id' => 2, 'desc' => 'Basketball', 'hasInplayEvents' => false, 'hasUpcomingEvents' => true, 'comp' => [] }]
			expected_output = [
				        { id: 1, title: 'Football', hasInplayEvents: 'Yes', hasUpcomingEvents: 'N/A', comp_size: 0 },
				        { id: 2, title: 'Basketball', hasInplayEvents: 'N/A', hasUpcomingEvents: 'Yes', comp_size: 0 }
				      ]
      		result = SportTransformation.sports(input)
      		expect(result).to eq(expected_output)
		end
	end
end