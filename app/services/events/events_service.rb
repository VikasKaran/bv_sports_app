module Events

  class EventsService
    def self.get_events(sports_data:, sport_id:)
      sport = sports_data.find { |s| s['id'] == sport_id }
      events = sport.nil? ? [] : sport['comp'].collect{|x| x['events']}.flatten
      return sport, events
    end
  end

end
