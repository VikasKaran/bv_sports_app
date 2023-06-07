class SportsController < ApplicationController

  def index
    sports_data = sports_events_client.sports_data
    if sports_data.is_a?(Hash) && sports_data.key?(:error)
      @error_code = sports_data[:error][:code]
      @error_message = sports_data[:error][:message]
    else 
      sports = sports_data.sort_by { |sport| sport['pos'] } || []
      @sports = sports.empty? ? [] : SportTransformation.sports(sports)
    end    

    respond_to do |format|
      format.html
      format.json { render :json => @sports.to_json}
    end
  end

  private

  def sports_events_client
    @sports_events_client ||= ApiClients::SportsEventsClient.new
  end
end
