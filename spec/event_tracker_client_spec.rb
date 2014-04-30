require "spec_helper"

describe EventTrackerClient do
  let(:host) { "localhost" }
  let(:port) { 3000 }

  it "send direct http request when track" do
    event_tracker_client = EventTrackerClient::EventTrackerClient.new(host, port, EventTrackerClient::Worker.new)

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
