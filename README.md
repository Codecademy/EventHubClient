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

The client support two apis and more details of the api can be found at https://github.com/Codecademy/EventTracker/

```ruby
event_tracker_client = EventTrackerClient::EventTrackerClient.new(host, port, EventTrackerClient::Worker.new)
event_tracker_client.track(event_type, user_id, event_properties)
event_tracker_client.alias(from_id, to_id)
```

## Contributing

1. Fork it ( https://github.com/Codecademy/event_tracker_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
