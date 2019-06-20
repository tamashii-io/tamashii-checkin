# frozen_string_literal: true

class EventAuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    event_id = env['grape.routing_args'][:event_id]
    return response_error(400, 'MissingEventId') unless event_id

    event = Event.find_by(id: event_id)
    return response_error(404, 'EventNotFound') unless event

    headers = ActionDispatch::Http::Headers.from_hash(env)
    return response_error(401, 'EventTokenMismatch') unless headers['Authorization'] == "Bearer #{event.api_token}"

    @app.call(env)
  end

  def response_error(error_code, msg)
    [error_code, { 'Content-Type' => 'application/json' }, [{ error: msg }.to_json]]
  end
end
