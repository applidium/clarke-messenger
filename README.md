# Clarke Messenger Documentation

Clarke Messenger is [Clarke](https://github.com/applidium/clarke/) UI plugin to interact with the [Facebook Messenger Platform](https://developers.facebook.com/docs/messenger-platform).

## API Route

In your messenger route code
```ruby
require 'clarke'
require 'clarke/messenger'
Clarke::Messenger::Config.facebook_page_token = 'your_facebook_page_token'

post '/messenger' do
  request_body = JSON.parse(request.body.read)
  Clarke.process_request(Clarke::Messenger, request_body)
end
```

## Events

There is 4 types of events:
* `TextMessage` (include `Clarke::TextMessage`)
* `Button` (include `Clarke::Button`)
* `Media` (include `Clarke::Media`)
* `Metadata` (include `Clarke::Metadata`)

All the Messenger Events have to the following attributes:
* `id`
* `timestamp`
* `sender` (the sender id)

### TextMessage
A `TextMessage` have to the following attribute: `text`

### Button
A `Button` have to the following attribute: `action` that is the messenger `payload`

### Media
A `TextMessage` have to the following attributes: `type` and `media`.
`type` is 'image', 'audio', 'video' or 'file'
`media` is the url of the attachment

### Metadata
Not implemented yet
