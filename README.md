# EventHubClient

The EventHubClient gem is a simple wrapper of EventHub HTTP APIs.

## Installation

Add this line to your application's Gemfile:

    gem 'event_hub_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install event_hub_client

## Usage

By the nature of the gem is supposed be used from the backend, The gem only supports two apis, track and alias. More details of about EventHub can be found at https://github.com/Codecademy/EventHub/

```ruby
event_hub_client = EventHubClient::EventHubClient.new(host, port, EventHubClient::Worker.new)
event_hub_client.track(event_type, user_id, event_properties)
event_hub_client.alias(from_id, to_id)
```

If the throughput from EventHubClient::EventHubClient is not good enough, consider using EventHubClient::BatchEventHubClient which batch send the requests. Please notice that you need to explicitly flush the BatchEventHubClient when your service is shutting down or there might be events buffered in the queue and those events might not get sent to the event hub server.

```ruby
base_event_hub_client = EventHubClient::EventHubClient.new(host, port, EventHubClient::Worker.new)
queue = []
batch_size = 10
batch_event_hub_client = EventHubClient::BatchEventHubClient.new(base_event_hub_client, queue, batch_size)
event_hub_client.track(event_type, user_id, event_properties)
event_hub_client.alias(from_id, to_id)
event_hub_client.flush
```

## Contributing

1. Fork it ( https://github.com/Codecademy/EventHubClient/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
