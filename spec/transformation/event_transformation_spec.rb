require 'rails_helper'

RSpec.describe 'EventTransformation' do
  describe '.event' do
    it 'transforms the input object into an event hash' do
      input = {
        'id' => 1,
        'desc' => 'Football Match',
        'scoreboard' => {
          'scrA' => 2,
          'scrB' => 1,
          'inPlay' => true
        }
      }
      expected_output = {
        id: 1,
        title: 'Football Match',
        scrA: 2,
        scrB: 1,
        inPlay: 'Yes'
      }

      result = EventTransformation.event(input)
      expect(result).to eq(expected_output)
    end
  end

  describe '.events' do
    it 'transforms the input object array into an array of event hashes' do
      input = [
        {
          'id' => 1,
          'desc' => 'Football Match',
          'scoreboard' => {
            'scrA' => 2,
            'scrB' => 1,
            'inPlay' => true
          }
        },
        {
          'id' => 2,
          'desc' => 'Basketball Game',
          'scoreboard' => {
            'scrA' => 80,
            'scrB' => 75,
            'inPlay' => false
          }
        }
      ]
      expected_output = [
        {
          id: 1,
          title: 'Football Match',
          scrA: 2,
          scrB: 1,
          inPlay: 'Yes'
        },
        {
          id: 2,
          title: 'Basketball Game',
          scrA: 80,
          scrB: 75,
          inPlay: 'No'
        }
      ]

      result = EventTransformation.events(input)
      expect(result).to eq(expected_output)
    end
  end
end
