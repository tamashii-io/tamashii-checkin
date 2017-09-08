# frozen_string_literal: true

class PansciEventService
  def initialize(event_id, secret)
    @event_id = event_id
    @secret = secret
  end

  def fetch_attendees
    uri = URI("#{Settings.pansci.api_uri}/api/v1/#{@event_id}/partic_list")
    uri.query = URI.encode_www_form(secret: @secret)
    JSON.parse(Net::HTTP.get(uri)).fetch('data')
  rescue JSON::ParserError
    []
  end
end
