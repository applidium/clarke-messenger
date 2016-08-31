module Clarke
  module Messenger
    module Events
      class Base
        attr_accessor :id, :timestamp
        def initialize (id, sender_id, timestamp)
          @id = id
          @sender_id = sender_id
          @timestamp = timestamp
        end

        # Generic functions that should be overided by Events classes in UI libs
        def sender
          @sender_id
        end

      end
    end
  end
end
