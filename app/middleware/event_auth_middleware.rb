# frozen_string_literal: true
class EventAuthMiddleware
  def initialize(app)
    @app = app
  end

  # rubocop:disable Metrics/MethodLength
  def call(env)
    event_id = env['grape.routing_args'][:event_id]
    if event_id
      event = Event.find_by(id: event_id)
      if event
        headers = ActionDispatch::Http::Headers.from_hash(env)
        if headers['Authorization'] == "Bearer #{event.api_token}"
          @app.call(env)
        else
          response_error(401, 'EventTokenMismatch')
        end
      else
        response_error(404, 'EventNotFound')
      end
    else
      response_error(400, 'MissingEventId')
    end
  end
  # rubocop:enable Metrics/MethodLength

  def response_error(error_code, msg)
    [error_code, { 'Content-Type' => 'application/json' }, [{ error: msg }.to_json]]
  end
end
