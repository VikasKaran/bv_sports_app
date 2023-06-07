module ApiClients

	class SportsEventsClient

	  def initialize
	    @sports_data = fetch_sports_data
	  end

	  def sports_data
	    JSON.parse(@sports_data.body)['sports']
	  end

	  private

	  def fetch_sports_data
	    HTTParty.get(URI(ENV['SPORTS_EVENTS_URL']))
	  rescue StandardError => e
	    Rails.logger.error("Failed to fetch sports data: #{e.message}")
	    nil
	  end

	end

end