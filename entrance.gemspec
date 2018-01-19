require './lib/entrance/version'

Gem::Specification.new do |s|
  s.name        = 'entrance'
  s.version     = Entrance::Version.to_s
  s.licenses    = ['MIT']
  s.summary     = 'An attempt to hook up a Rails action controller with Grape parameter validation DSL'
  s.authors     = ["Edward Tam"]
  s.email       = 'edward.tam@wishabi.com'
  s.files       = ['lib/entrance.rb']

  s.add_development_dependency 'grape', '~> 1.0.2'
  s.add_development_dependency 'actionpack', '>= 3.2.0'
end