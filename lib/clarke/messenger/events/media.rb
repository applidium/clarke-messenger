module Clarke
  module Messenger
    module Events
      class Media < Messenger::Events::Base
        include Clarke::Events::Media
        attr_accessor :type, :media

        def initialize (id, sender_id, timestamp, type, media)
          super(id, sender_id, timestamp)
          @type = type
          @media = media
        end
      end
    end
  end
end
