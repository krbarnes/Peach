Gem::Specification.new do |s|
  s.name        = 'peach'
  s.version     = '0.0.0'
  s.date        = '2019-04-03'
  s.summary     = 'Manage your iOS simulators with a yml file.'
  s.description = 'Manage your iOS simulators with a yml file.'
  s.authors     = ['Kevin Barnes']
  s.email       = 'iamkevb@gmail.com'
  s.files       = ['lib/peach.rb', 'lib/peach/device.rb', 'lib/peach/xc.rb']
  s.homepage    = 'http://rubygems.org/gems/peach'
  s.license     = 'MIT'
  s.add_runtime_dependency 'plist'
end