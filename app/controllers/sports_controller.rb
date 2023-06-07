class SportsController < ApplicationController

  def index
    sports_data = sports_client.sports_data
    if @sports.is_a?(Hash) && sports_data.key?(:error)
      @error_code = sports_data[:error][:code]
      @error_message = sports_data[:error][:message]
    else
      @sports = sports_data.sort_by { |sport| sport['pos'] } || []
    end    

    respond_to do |format|
      format.html
      format.json { render :json => @sports.to_json}
    end
  end

  private

  def sports_client
    @sports_client ||= ApiClients::SportsEventsClient.new
  end
end
