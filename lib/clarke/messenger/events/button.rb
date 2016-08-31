module Clarke
  module Messenger
    module Events
      class Button < Messenger::Events::Base
        include Clarke::Events::Button
        attr_accessor :action

        def initialize (id, sender_id, timestamp, action)
          @action = action
          super(id, sender_id, timestamp)
        end
      end
    end
  end
end
