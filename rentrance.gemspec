require './lib/rentrance/version'

Gem::Specification.new do |s|
  s.name        = 'rentrance'
  s.version     = Rentrance::Version.to_s
  s.licenses    = ['MIT']
  s.summary     = 'An attempt to hook up a Rails action controller with Grape parameter validation DSL'
  s.authors     = ["Edward Tam"]
  s.email       = 'edward.tam@wishabi.com'
  s.files       = ['lib/rentrance.rb']

  s.add_development_dependency 'grape', '~> 1.0'
  s.add_development_dependency 'actionpack', '>= 3.2.0'
end