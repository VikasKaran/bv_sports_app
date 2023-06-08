require 'rails_helper'

RSpec.describe ApiClients::SportsEventsClient do
  describe '#sports_data' do
    let(:sports_data_client) { described_class.new }

    context 'when the API call is successful' do
      let(:response_body) do
        {
          'sports' => [
            { 'id' => 1, 'name' => 'Football' },
            { 'id' => 2, 'name' => 'Basketball' }
          ]
        }.to_json
      end

      before do
        allow(HTTParty).to receive(:get).and_return(
          instance_double('HTTParty::Response', success?: true, body: response_body)
        )
      end

      it 'returns the parsed sports data' do
        expected_result = [
          { 'id'=> 1, 'name'=> 'Football' },
          { 'id'=> 2, 'name'=> 'Basketball' }
        ]

        result = sports_data_client.sports_data

        expect(result).to eq(expected_result)
      end
    end

    context 'when the API call fails' do
      before do
        allow(HTTParty).to receive(:get).and_raise(StandardError, 'API call failed')
      end

      it 'returns an error hash' do
        expected_result = {
          error: {
            code: 500,
            message: 'Failed to retrieve sports data. Please try again later.'
          }
        }

        result = sports_data_client.sports_data

        expect(result).to eq(expected_result)
      end
    end
  end
end
