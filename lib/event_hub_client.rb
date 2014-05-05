require "event_hub_client/version"
require "net/http"
require "typhoeus"
require 'json'

module EventHubClient
  class Worker
    def perform(url, body)
      Typhoeus::Request.post(url, body: body)
    end
  end

  class BatchEventHubClient
    attr_reader :client, :queue, :batch_size

    def initialize(client, queue, batch_size)
      @client = client
      @queue = queue
      @batch_size = batch_size
    end

    def track(event_type, user_id, event_properties)
      params = {}.merge(event_properties).merge({
        "event_type" => event_type,
        "external_user_id" => user_id,
      })
      queue.push(params)
      if queue.size % batch_size == 0
        client.send_request("events/batch_track", { "events" => queue.to_json })
        @queue = []
      end
    end

    def flush
      client.send_request("events/batch_track", { "events" => queue.to_json })
      @queue = []
    end

    def alias(from_id, to_id)
      client.alias(from_id, to_id)
    end
  end

  class EventHubClient
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

    def send_request(path, body)
      worker.perform("http://#{@host}:#{@port}/#{path}", body)
    end
  end
end
