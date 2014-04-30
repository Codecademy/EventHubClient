require "event_tracker_client/version"
require "net/http"
require "typhoeus"

module EventTrackerClient
  class Worker
    def perform(url, body)
      Typhoeus::Request.post(url, body: body)
    end
  end

  class EventTrackerClient
    attr_reader :host, :port, :worker

    def initialize(host, port, worker)
      @host = host
      @port = port
      @worker = worker
    end
  
    def track(event_type, user_id, event_properties)
      path = "events/track"
  
      params = {}.merge(event_properties).merge({
        "event_type" => event_type,
        "external_user_id" => user_id,
      })
  
      send_request(path, params)
    end
  
    def alias(from_id, to_id)
      path = "users/alias"
      params = {
        "from_external_user_id" => from_id,
        "to_external_user_id" => to_id
      }
  
      send_request(path, params)
    end
  
    private
  
    def send_request(path, body)
      worker.perform("http://#{@host}:#{@port}/#{path}", body)
    end
  end
end
