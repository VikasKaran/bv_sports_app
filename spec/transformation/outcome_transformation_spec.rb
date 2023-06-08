require 'rails_helper'

RSpec.describe 'OutcomeTransformation' do
  describe '.outcome' do
    it 'transforms the input object into an outcome hash' do
      input = {
        'oid' => 123168468809,
        'd' => 'Elina Svitolina',
        'pr' => '12/5',
        'keyDimension' => 'HOME'
      }
      expected_output = {
        id: 123168468809,
        title: 'Elina Svitolina',
        pr: '12/5',
        keyDimension: 'HOME'
      }

      result = OutcomeTransformation.outcome(input)

      expect(result).to eq(expected_output)
    end
  end

  describe '.outcomes' do
    it 'transforms the input object array into an array of outcome hashes' do
      input = [
        {
          'oid' => 123168468809,
          'd' => 'Elina Svitolina',
          'pr' => '12/5',
          'keyDimension' => 'HOME'
        },
        {
          'oid' => 2,
          'd' => 'Outcome 2',
          'pr' => 1.8,
          'keyDimension' => 'Dimension B'
        }
      ]
      expected_output = [
        {
          id: 123168468809,
          title: 'Elina Svitolina',
          pr: '12/5',
          keyDimension: 'HOME'
        },
        {
          id: 2,
          title: 'Outcome 2',
          pr: 1.8,
          keyDimension: 'Dimension B'
        }
      ]

      result = OutcomeTransformation.outcomes(input)

      expect(result).to eq(expected_output)
    end
  end
end
