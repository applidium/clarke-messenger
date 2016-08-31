module Clarke
  module Messenger
    module Events
      class Metadata < Messenger::Events::Base
        include Clarke::Events::Metadata
        attr_accessor :type, :data

        def initialize (id, sender_id, timestamp, type, data)
          super(id, sender_id, timestamp)
          @type = type
          @data = data
        end
      end
    end
  end
end
