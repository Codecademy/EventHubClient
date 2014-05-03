require "spec_helper"

describe EventTrackerClient do
  let(:host) { "localhost" }
  let(:port) { 3000 }

  context "for BatchEventTrackerClient" do
    let(:queue) { Array.new }
    let(:batch_size) { 2 }
    let(:event_tracker_client) {
      EventTrackerClient::BatchEventTrackerClient.new(
        EventTrackerClient::EventTrackerClient.new(host, port, EventTrackerClient::Worker.new), queue, batch_size)
    }

    it "send direct http request when alias" do
      from_id = "hello"
      to_id = "bar"

      expect(Typhoeus::Request).to receive(:post).with("http://#{host}:#{port}/users/alias", { 
        :body => { 
          "from_external_user_id" => from_id,
          "to_external_user_id" => to_id
      }}).once
      event_tracker_client.alias(from_id, to_id)
    end

    it "batch track requests" do
      event_types = [ "TYPE1", "TYPE2", "TYPE3", "TYPE4", "TYPE5" ]
      user_ids = [ "foo1", "foo2", "foo3", "foo4", "foo5" ]
      event_properties = [
        { "foo1" => "bar1" },
        { "foo2" => "bar2" },
        { "foo3" => "bar3" },
        { "foo4" => "bar4" },
        { "foo5" => "bar5" },
      ]
  
      expect(Typhoeus::Request).to receive(:post).with("http://#{host}:#{port}/events/batch_track", { 
        :body => { 
          "events" => [
              {
                "foo1" => "bar1",
                "event_type" => event_types[0],
                "external_user_id" => user_ids[0],
              }, {
                "foo2" => "bar2",
                "event_type" => event_types[1],
                "external_user_id" => user_ids[1],
              }].to_json
      }}).once
      expect(Typhoeus::Request).to receive(:post).with("http://#{host}:#{port}/events/batch_track", { 
        :body => { 
          "events" => [
              {
                "foo3" => "bar3",
                "event_type" => event_types[2],
                "external_user_id" => user_ids[2],
              }, {
                "foo4" => "bar4",
                "event_type" => event_types[3],
                "external_user_id" => user_ids[3],
              }].to_json
      }}).once
      (0..4).each do |i|
        event_tracker_client.track(event_types[i], user_ids[i], event_properties[i])
      end
    end
  end

  context "for EventTrackerClient" do
    let(:event_tracker_client) {
      EventTrackerClient::EventTrackerClient.new(host, port, EventTrackerClient::Worker.new)
    }

    it "send direct http request when alias" do
      from_id = "hello"
      to_id = "bar"

      expect(Typhoeus::Request).to receive(:post).with("http://#{host}:#{port}/users/alias", { 
        :body => { 
          "from_external_user_id" => from_id,
          "to_external_user_id" => to_id
      }}).once
      event_tracker_client.alias(from_id, to_id)
    end

    it "send direct http request when track" do
      event_type = "TYPE"
      user_id = "chengtao@codeecademy.com"
      event_properties = { "foo" => "bar" }
  
      expect(Typhoeus::Request).to receive(:post).with("http://#{host}:#{port}/events/track", { 
        :body => { 
          "event_type" => event_type,
          "external_user_id" => user_id,
          "foo" => "bar"
      }}).once
      event_tracker_client.track(event_type, user_id, event_properties)
    end
  end
end
