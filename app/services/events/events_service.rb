module Events

  class EventsService
    def self.get_events(sports_data:, sport_id:)
      sport = sports_data.find { |s| s['id'] == sport_id }
      events = sport.nil? ? [] : sport['comp'].collect{|x| x['events']}.flatten
      return sport, events
    end

    def self.get_outcomes(sports_data:, sport_id:, event_id:)
      sport, events = get_events(sports_data: sports_data, sport_id: sport_id)
      if events.empty?
        return [], []
      else
        event = events.find { |s| s['id'] == event_id }
        outcomes = event.nil? ? [] : event['markets'].flat_map { |m| m['o'] }
        return event, outcomes
      end
    end
  end

end
