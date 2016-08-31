$:.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'clarke/messenger/version'

# TODO : Add the rubbot dependencie

Gem::Specification.new do |s|
  s.name        = 'clarke-messenger'
  s.version     = Clarke::Messenger::VERSION
  s.summary     = "Clarke-messenger is a plugin for clarke to interact with Facebook Messenger."
  s.description = "Facebook Messenger plugin for Clarke."

  s.license     = "MIT"

  s.authors     = ['Applidium', 'Cyril Canete']
  s.email       = 'contact+clarke-messenger@applidium.com'
  s.homepage    = "https://github.com/applidium/clarke-messenger/"

  s.files       = Dir["CHANGELOG.md", "CONTRIBUTORS", "README.md", "LICENSE", "lib/**/*"]
  s.require_paths = ['lib']

  s.add_dependency 'http'
  s.add_runtime_dependency 'clarke', '~> 0.2.0'

  s.add_development_dependency 'rack',            '~> 1.6', '> 1.6'
  s.add_development_dependency 'test-unit',       '~> 3.0', '>= 3.0.0'

end
