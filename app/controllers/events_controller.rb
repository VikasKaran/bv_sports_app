class EventsController < ApplicationController

  def index
    sports_events_data = sports_events_client.sports_data

    if sports_events_data.is_a?(Hash) && sports_events_data.key?(:error)
      @error_code = sports_events_data[:error][:code]
      @error_message = sports_events_data[:error][:message]
    else
      sport, events = Events::EventsService.get_events(sports_data: sports_events_data, sport_id: params[:sport_id].to_i)
      @sport = sport.nil? ? [] : SportTransformation.sport(sport)
      @events = events.empty? ? [] : EventTransformation.events(events)
    end

    respond_to do |format|
      format.html
      format.json { render :json => ({events: @events, sport: @sport}).to_json}
    end
  end

  def show

    sports_events_data = sports_events_client.sports_data

    if sports_events_data.is_a?(Hash) && sports_events_data.key?(:error)
      @error_code = sports_events_data[:error][:code]
      @error_message = sports_events_data[:error][:message]
    else
      event, outcomes = Events::EventsService.get_outcomes(sports_data: sports_events_data, sport_id: params[:sport_id].to_i,  event_id: params[:id].to_i)
      @event = event.nil? ? [] : EventTransformation.event(event)
      @outcomes = outcomes.empty? ? [] : OutcomeTransformation.outcomes(outcomes)
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => ({event: @event, outcomes: @outcomes}).to_json}
    end

  end

  private

  def sports_events_client
    @sports_events_client ||= ApiClients::SportsEventsClient.new
  end

end
