class SportsController < ApplicationController

  def index
    sports_data = sports_client.sports_data
    @sports = sports_data.sort_by { |sport| sport['pos'] } || []

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
