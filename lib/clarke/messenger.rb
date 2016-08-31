require 'clarke'
require 'http'

# Version
require 'clarke/messenger/version'

# Models
require 'clarke/messenger/events/base'
require 'clarke/messenger/events/button'
require 'clarke/messenger/events/media'
require 'clarke/messenger/events/metadata'
require 'clarke/messenger/events/text_message'

require 'clarke/messenger/responses/base'
require 'clarke/messenger/responses/attachment'
require 'clarke/messenger/responses/button_template'
require 'clarke/messenger/responses/generic_template'
require 'clarke/messenger/responses/quick_replies_template'
require 'clarke/messenger/responses/text_message'

# Ressources
require 'clarke/messenger/interface'
require 'clarke/messenger/config'

require 'clarke/messenger/message_parser/strategies'
require 'clarke/messenger/response_converter'
require 'clarke/messenger/response_sender'
