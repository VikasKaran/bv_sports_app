class EventsController < ApplicationController

  def index
    sports_events_data = sports_events_client.sports_data

    if sports_events_data.is_a?(Hash) && sports_events_data.key?(:error)
      @error_code = sports_events_data[:error][:code]
      @error_message = sports_events_data[:error][:message]
    else
      events = Events::EventsService.get_events(sports_data: sports_events_data, sport_id: params[:sport_id])
      @events = events.empty? ? [] : EventTransformation.events(events)
    end

    respond_to do |format|
      format.html
      format.json { render :json => @events.to_json}
    end
  end

  def show
  end

  private

  def sports_events_client
    @sports_events_client ||= ApiClients::SportsEventsClient.new
  end

end
