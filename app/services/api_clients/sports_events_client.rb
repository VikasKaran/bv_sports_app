module ApiClients

	class SportsEventsClient

	  def initialize
	    @sports_data = fetch_sports_data
	  end

	  def sports_data
	    if @sports_data.nil?
	      {
	        error: {
	          code: nil,
	          message: 'Failed to retrieve sports data. Please try again later.'
	        }
	      }
	    elsif @sports_data.success?
	      JSON.parse(@sports_data.body)['sports']
	    else
	      {
	        error: {
	          code: @sports_data.code,
	          message: @sports_data.message
	        }
	      }
	    end
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