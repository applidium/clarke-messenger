module Clarke
  module Messenger
    module Config

      API_ENDPOINT = "https://graph.facebook.com/v2.6/me/messages"

      class << self

        attr_accessor :facebook_page_token

      end

    end
  end
end
