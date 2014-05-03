# EventTrackerClient

The EventTrackerClient gem is a simple wrapper of EventTracker HTTP APIs.

## Installation

Add this line to your application's Gemfile:

    gem 'event_tracker_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install event_tracker_client

## Usage

By the nature of the gem is supposed be used from the backend, The gem only supports two apis, track and alias. More details of about EventTracker can be found at https://github.com/Codecademy/EventTracker/

```ruby
event_tracker_client = EventTrackerClient::EventTrackerClient.new(host, port, EventTrackerClient::Worker.new)
event_tracker_client.track(event_type, user_id, event_properties)
event_tracker_client.alias(from_id, to_id)
```

If there are the throughput of EventTrackerClient::EventTrackerClient is not good enough, consider using EventTrackerClient::BatchEventTrackerClient which batch send the requests.

```ruby
base_event_tracker_client = EventTrackerClient::EventTrackerClient.new(host, port, EventTrackerClient::Worker.new)
queue = []
batch_size = 10
batch_event_tracker_client = EventTrackerClient::BatchEventTrackerClient.new(base_event_tracker_client, queue, batch_size)
event_tracker_client.track(event_type, user_id, event_properties)
event_tracker_client.alias(from_id, to_id)
```

## Contributing

1. Fork it ( https://github.com/Codecademy/event_tracker_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
